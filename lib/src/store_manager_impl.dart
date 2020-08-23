import 'dart:async';

import 'context_manager.dart';
import 'interfaces.dart';
import 'store_repository.dart';
import 'types.dart';

class StoreManagerImpl implements StoreManager {
  StoreManagerImpl(this._context, this._repository) {
    _executionZoneSpecification = _createExecutionZoneSpecification();
  }

  final ContextManager _context;
  final StoreRepository _repository;

  ZoneSpecification _executionZoneSpecification;

  var _hasTransanction = false;

  @override
  V read<M, V>(Read<M, V> fn) => fn(_getModel());

  @override
  V readUnary<M, V, X>(ReadUnary<M, V, X> fn, X x) => fn(_getModel(), x);

  @override
  V readBinary<M, V, X, Y>(ReadBinary<M, V, X, Y> fn, X x, Y y) =>
      fn(_getModel(), x, y);

  @override
  FutureOr<void> apply<A>(Apply<A> fn) => _hasTransanction
      ? fn(_getAccumulator())
      : _context.run(
          () => fn(_getAccumulator()),
          specification: _executionZoneSpecification,
        );

  @override
  FutureOr<void> applyUnary<A, X>(ApplyUnary<A, X> fn, X x) => _hasTransanction
      ? fn(_getAccumulator(), x)
      : _context.run(
          () => fn(_getAccumulator(), x),
          specification: _executionZoneSpecification,
        );

  @override
  FutureOr<void> applyBinary<A, X, Y>(ApplyBinary<A, X, Y> fn, X x, Y y) =>
      _hasTransanction
          ? fn(_getAccumulator(), x, y)
          : _context.run(
              () => fn(_getAccumulator(), x, y),
              specification: _executionZoneSpecification,
            );

  M _getModel<M>() =>
      M == StoreReader ? _getCastedThis() : _repository.getModel();

  A _getAccumulator<A>() =>
      A == StoreManager || A == StoreExecutor || A == StoreReader
          ? _getCastedThis()
          : _repository.getAccumulator();

  T _getCastedThis<T>() => this as T; // ignore: avoid_as

  ZoneSpecification _createExecutionZoneSpecification() {
    return ZoneSpecification(
      run: <R>(source, parent, zone, fn) {
        return _hasTransanction
            ? parent.run(zone, fn)
            : _runTransanction(() => parent.run(zone, fn), source);
      },
      runUnary: <R, X>(source, parent, zone, fn, x) {
        return _hasTransanction
            ? parent.runUnary(zone, fn, x)
            : _runTransanction(() => parent.runUnary(zone, fn, x), source);
      },
      runBinary: <R, X, Y>(source, parent, zone, fn, x, y) {
        return _hasTransanction
            ? parent.runBinary(zone, fn, x, y)
            : _runTransanction(() => parent.runBinary(zone, fn, x, y), source);
      },
    );
  }

  T _runTransanction<T>(T Function() fn, Zone source) {
    _hasTransanction = true;
    final result = fn();
    _context.run(_repository.applyChanges, source: source);
    _hasTransanction = false;
    return result;
  }
}
