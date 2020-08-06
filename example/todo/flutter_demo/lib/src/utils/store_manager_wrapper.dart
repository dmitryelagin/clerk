import 'dart:async';

import 'package:clerk/clerk.dart';

class StoreManagerWrapper implements StoreManager {
  StoreManagerWrapper(this._store) {
    // TODO: Change to teardown stream
    _subscriptions[StateAggregate] =
        _store.accessor.onChange.listen(null, onDone: teardown);
  }

  final Store _store;

  final _subscriptions = <Type, StreamSubscription<Object>>{};
  final _change = StreamController<Object>(sync: true);

  Stream<Object> get onChange => _change.stream;

  @override
  void apply<A>(Apply<A> fn) => _store.executor.apply(fn);

  @override
  void applyUnary<A, X>(ApplyUnary<A, X> fn, X x) =>
      _store.executor.applyUnary(fn, x);

  @override
  void applyBinary<A, X, Y>(ApplyBinary<A, X, Y> fn, X x, Y y) =>
      _store.executor.applyBinary(fn, x, y);

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
    _change.close();
  }

  void _checkSubscription<M>() {
    if (_subscriptions.containsKey(M)) return;
    _subscriptions[M] = _store.accessor
        .onModelChange<M>()
        .listen(_change.add, onDone: teardown);
  }
}
