import 'dart:async';

import 'package:clerk/clerk.dart';

import 'store_porter.dart';
import 'store_trigger.dart';

class StorePorterImpl implements StorePorter {
  StorePorterImpl(this._store, this._trigger);

  final Store _store;
  final StoreTrigger _trigger;

  final _change = StreamController<void>(sync: true);
  final _subscriptions = <Type>{};

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
  void execute(Action action) {
    return _store.executor.execute(action);
  }

  void teardown() {
    _change.close();
  }

  void _checkSubscription<M>() {
    if (_subscriptions.contains(M)) return;
    if (_trigger == StoreTrigger.sync) {
      _store.accessor.onModelChange<M>().listen(_change.add);
    }
    if (_trigger == StoreTrigger.after) {
      _store.accessor.onAfterModelChanges<M>().listen(_change.add);
    }
    _subscriptions.add(M);
  }
}
