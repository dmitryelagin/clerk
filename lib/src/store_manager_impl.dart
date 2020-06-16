import 'dart:async';

import 'action.dart';
import 'interfaces_private.dart';
import 'interfaces_public.dart';
import 'state_repository.dart';
import 'store_settings.dart';
import 'types_public.dart';
import 'types_utils.dart';

class StoreManagerImpl implements StoreManager, StoreActionEventBus {
  StoreManagerImpl(StoreSettings settings, this._repository)
      : _action = settings.getStreamController();

  final StateRepository _repository;
  final StreamController<Action> _action;

  @override
  Stream<Action> get onAction => _action.stream;

  @override
  void execute(Action action) {
    if (action == null || _repository.isTeardowned) return;
    _action.add(action);
    action.execute(this);
  }

  @override
  V read<M, V>(Read<M, V> fn) {
    return fn.isGeneric && !_repository.hasModel<M>()
        ? fn(_getReader())
        : _repository.getByModel<M>().read(fn);
  }

  @override
  V readUnary<M, V, X>(ReadUnary<M, V, X> fn, X x) {
    return fn.isGeneric && !_repository.hasModel<M>()
        ? fn(_getReader(), x)
        : _repository.getByModel<M>().readUnary(fn, x);
  }

  @override
  V readBinary<M, V, X, Y>(ReadBinary<M, V, X, Y> fn, X x, Y y) {
    return fn.isGeneric && !_repository.hasModel<M>()
        ? fn(_getReader(), x, y)
        : _repository.getByModel<M>().readBinary(fn, x, y);
  }

  @override
  void write<A, V>(Write<A, V> fn) {
    _repository.getByAccumulator<A>().write(fn);
  }

  @override
  void writeUnary<A, V, X>(WriteUnary<A, V, X> fn, X x) {
    _repository.getByAccumulator<A>().writeUnary(fn, x);
  }

  @override
  void writeBinary<A, V, X, Y>(WriteBinary<A, V, X, Y> fn, X x, Y y) {
    _repository.getByAccumulator<A>().writeBinary(fn, x, y);
  }

  Future<void> teardown() => _action.close();

  T _getReader<T>() => this as T; // ignore: avoid_as
}
