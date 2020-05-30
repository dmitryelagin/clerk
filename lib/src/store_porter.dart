import 'dart:async';

import 'action.dart';
import 'interfaces_public.dart';
import 'interfaces_utils.dart';
import 'types_private.dart';
import 'types_public.dart';
import 'types_utils.dart';

/// An object that is a facade for values evaluation and [Action]s execution.
///
/// When [StorePorter] evaluates some [Selector]s it automatically starts to
/// listen the changes of corresponding models. So, with [StorePorter.onChange]
/// anything can keep track of changes inside [StorePorter] scope. It is
/// useful for cases when an app can be updated partially, but it is unknown
/// which specific models this part depends on.
class StorePorter implements StoreExecutor, StoreEvaluator {
  /// Creates [StorePorter] which immediately notifies about changes.
  ///
  /// It will use [StoreAccessor.onModelChange()] to collect changes.
  StorePorter(this._evaluator, this._executor, StoreAccessor accessor)
      : _getChanges = accessor.onModelChange {
    _setUpTeardown(accessor);
  }

  /// Creates [StorePorter] which notifies about changes in microtask.
  ///
  /// It will use [StoreAccessor.onAfterModelChanges()] to collect changes.
  StorePorter.after(this._evaluator, this._executor, StoreAccessor accessor)
      : _getChanges = accessor.onAfterModelChanges {
    _setUpTeardown(accessor);
  }

  final StoreEvaluator _evaluator;
  final StoreExecutor _executor;
  final StreamFactory _getChanges;

  final _subscriptions = <Type>{};
  final _change = StreamController<Object>(sync: true);

  /// A stream that emits models of this [StorePorter] scope that were changed.
  ///
  /// It will emit models which were provided to [Selector] at least once.
  Stream<Object> get onChange => _change.stream;

  @override
  void execute(Action action) => _executor.execute(action);

  @override
  V evaluate<M, V>(Selector<M, V> select) {
    if (select.isGeneric) return select(castEvaluator());
    _checkSubscription<M>();
    return _evaluator.evaluate(select);
  }

  @override
  V evaluateUnary<M, V, X>(SelectorUnary<M, V, X> select, X x) {
    if (select.isGeneric) return select(castEvaluator(), x);
    _checkSubscription<M>();
    return _evaluator.evaluateUnary(select, x);
  }

  @override
  V evaluateBinary<M, V, X, Y>(SelectorBinary<M, V, X, Y> select, X x, Y y) {
    if (select.isGeneric) return select(castEvaluator(), x, y);
    _checkSubscription<M>();
    return _evaluator.evaluateBinary(select, x, y);
  }

  /// Closes this [StorePorter] only.
  void teardown() {
    _change.close();
  }

  void _setUpTeardown(StoreAccessor accessor) {
    accessor.onChange.listen(null, onDone: teardown);
  }

  void _checkSubscription<M>() {
    if (_subscriptions.contains(M)) return;
    _getChanges<M>().listen(_change.add);
    _subscriptions.add(M);
  }
}
