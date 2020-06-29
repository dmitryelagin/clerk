import 'dart:async';

import 'package:clerk/clerk.dart';

class StorePorter implements StoreExecutor, StoreReader {
  StorePorter(this._reader, this._executor, this._accessor) {
    _subscriptions[StateAggregate] =
        _accessor.onAfterChanges.listen(null, onDone: teardown);
  }

  final StoreReader _reader;
  final StoreExecutor _executor;
  final StoreAccessor _accessor;

  final _subscriptions = <Type, StreamSubscription<Object>>{};
  final _afterChanges = StreamController<Object>(sync: true);

  Stream<Object> get onAfterChanges => _afterChanges.stream;

  @override
  void execute(Execute fn) => _executor.execute(fn);

  @override
  void executeUnary<X>(ExecuteUnary<X> fn, X x) =>
      _executor.executeUnary(fn, x);

  @override
  void executeBinary<X, Y>(ExecuteBinary<X, Y> fn, X x, Y y) =>
      _executor.executeBinary(fn, x, y);

  @override
  V read<M, V>(Read<M, V> fn) {
    _checkSubscription<M>();
    return _reader.read(fn);
  }

  @override
  V readUnary<M, V, X>(ReadUnary<M, V, X> fn, X x) {
    _checkSubscription<M>();
    return _reader.readUnary(fn, x);
  }

  @override
  V readBinary<M, V, X, Y>(ReadBinary<M, V, X, Y> fn, X x, Y y) {
    _checkSubscription<M>();
    return _reader.readBinary(fn, x, y);
  }

  void teardown() {
    for (final subscription in _subscriptions.values) {
      subscription.cancel();
    }
    _afterChanges.close();
  }

  void _checkSubscription<M>() {
    if (_subscriptions.containsKey(M)) return;
    _subscriptions[M] = _accessor
        .onAfterModelChanges<M>()
        .listen(_afterChanges.add, onDone: teardown);
  }
}
