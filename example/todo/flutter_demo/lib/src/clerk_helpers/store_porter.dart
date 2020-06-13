import 'dart:async';

import 'package:clerk/clerk.dart';

class StorePorter implements StoreExecutor, StoreEvaluator {
  StorePorter(this._evaluator, this._executor, this._accessor) {
    _subscriptions[StateAggregate] =
        _accessor.onChange.listen(null, onDone: teardown);
  }

  final StoreEvaluator _evaluator;
  final StoreExecutor _executor;
  final StoreAccessor _accessor;

  final _subscriptions = <Type, StreamSubscription<Object>>{};
  final _change = StreamController<Object>(sync: true);

  Stream<Object> get onChange => _change.stream;

  @override
  void execute(Action action) => _executor.execute(action);

  @override
  V evaluate<M, V>(Selector<M, V> select) {
    _checkSubscription<M>();
    return _evaluator.evaluate(select);
  }

  @override
  V evaluateUnary<M, V, X>(SelectorUnary<M, V, X> select, X x) {
    _checkSubscription<M>();
    return _evaluator.evaluateUnary(select, x);
  }

  @override
  V evaluateBinary<M, V, X, Y>(SelectorBinary<M, V, X, Y> select, X x, Y y) {
    _checkSubscription<M>();
    return _evaluator.evaluateBinary(select, x, y);
  }

  void teardown() {
    for (final subscription in _subscriptions.values) {
      subscription.cancel();
    }
    _change.close();
  }

  void _checkSubscription<M>() {
    if (_subscriptions.containsKey(M)) return;
    _subscriptions[M] =
        _accessor.onModelChange<M>().listen(_change.add, onDone: teardown);
  }
}
