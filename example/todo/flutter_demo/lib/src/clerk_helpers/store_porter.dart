import 'dart:async';

import 'package:clerk/clerk.dart';

class StorePorter implements StoreEvaluator, StoreExecutor {
  StorePorter(this._store) : _getChanges = _store.accessor.onModelChange;

  StorePorter.after(this._store)
      : _getChanges = _store.accessor.onAfterModelChanges;

  final Store _store;
  final Stream<M> Function<M>() _getChanges;

  final _subscriptions = <Type>{};
  final _change = StreamController<void>(sync: true);

  Stream<void> get onChange => _change.stream;

  @override
  V evaluate<M, V>(Selector<M, V> select) {
    _checkSubscription<M>();
    return _store.evaluator.evaluate(select);
  }

  @override
  V evaluateUnary<M, V, X>(SelectorUnary<M, V, X> select, X x) {
    _checkSubscription<M>();
    return _store.evaluator.evaluateUnary(select, x);
  }

  @override
  V evaluateBinary<M, V, X, Y>(SelectorBinary<M, V, X, Y> select, X x, Y y) {
    _checkSubscription<M>();
    return _store.evaluator.evaluateBinary(select, x, y);
  }

  @override
  void execute(Action action) => _store.executor.execute(action);

  void teardown() {
    _change.close();
  }

  void _checkSubscription<M>() {
    if (_subscriptions.contains(M)) return;
    _getChanges<M>().listen(_change.add);
    _subscriptions.add(M);
  }
}
