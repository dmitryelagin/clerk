import 'dart:async';

import 'package:clerk/clerk.dart';

class StorePorter implements StoreExecutor, StoreReader {
  StorePorter(this._store) {
    _subscriptions[StateAggregate] =
        _store.accessor.onAfterChanges.listen(null, onDone: teardown);
  }

  final Store _store;

  final _subscriptions = <Type, StreamSubscription<Object>>{};
  final _afterChanges = StreamController<Object>(sync: true);

  Stream<Object> get onAfterChanges => _afterChanges.stream;

  @override
  void run(Run fn) => _store.executor.run(fn);

  @override
  void runUnary<X>(RunUnary<X> fn, X x) => _store.executor.runUnary(fn, x);

  @override
  void runBinary<X, Y>(RunBinary<X, Y> fn, X x, Y y) =>
      _store.executor.runBinary(fn, x, y);

  @override
  V read<M, V>(Read<M, V> fn) {
    _checkSubscription<M>();
    return _store.reader.read(fn);
  }

  @override
  V readUnary<M, V, X>(ReadUnary<M, V, X> fn, X x) {
    _checkSubscription<M>();
    return _store.reader.readUnary(fn, x);
  }

  @override
  V readBinary<M, V, X, Y>(ReadBinary<M, V, X, Y> fn, X x, Y y) {
    _checkSubscription<M>();
    return _store.reader.readBinary(fn, x, y);
  }

  void teardown() {
    for (final subscription in _subscriptions.values) {
      subscription.cancel();
    }
    _afterChanges.close();
  }

  void _checkSubscription<M>() {
    if (_subscriptions.containsKey(M)) return;
    _subscriptions[M] = _store.accessor
        .onAfterModelChanges<M>()
        .listen(_afterChanges.add, onDone: teardown);
  }
}
