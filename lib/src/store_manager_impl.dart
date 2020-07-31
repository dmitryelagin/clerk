import 'dart:async';

import 'interfaces.dart';
import 'store_repository.dart';
import 'types.dart';
import 'types_utils.dart';

class StoreManagerImpl implements StoreExecutor, StoreManager {
  StoreManagerImpl(this._repository) {
    _executionZone = _createExecutionZone();
  }

  final StoreRepository _repository;

  Zone _executionZone;

  var _hasTransanction = false;

  bool get _canStartTransanction =>
      !_hasTransanction && !_repository.isTeardowned;

  @override
  V read<M, V>(Read<M, V> fn) {
    return fn.isGeneric && !_repository.hasModel<M>()
        ? fn(_getTypedThis())
        : _repository.getByModel<M>().read(fn);
  }

  @override
  V readUnary<M, V, X>(ReadUnary<M, V, X> fn, X x) {
    return fn.isGeneric && !_repository.hasModel<M>()
        ? fn(_getTypedThis(), x)
        : _repository.getByModel<M>().readUnary(fn, x);
  }

  @override
  V readBinary<M, V, X, Y>(ReadBinary<M, V, X, Y> fn, X x, Y y) {
    return fn.isGeneric && !_repository.hasModel<M>()
        ? fn(_getTypedThis(), x, y)
        : _repository.getByModel<M>().readBinary(fn, x, y);
  }

  @override
  void apply<A>(Apply<A> fn) {
    if (fn.isExecution && !_repository.hasAccumulator<A>()) {
      fn(_getTypedThis());
    } else {
      _repository.getByAccumulator<A>().apply(fn);
    }
  }

  @override
  void applyUnary<A, X>(ApplyUnary<A, X> fn, X x) {
    if (fn.isExecution && !_repository.hasAccumulator<A>()) {
      fn(_getTypedThis(), x);
    } else {
      _repository.getByAccumulator<A>().applyUnary(fn, x);
    }
  }

  @override
  void applyBinary<A, X, Y>(ApplyBinary<A, X, Y> fn, X x, Y y) {
    if (fn.isExecution && !_repository.hasAccumulator<A>()) {
      fn(_getTypedThis(), x, y);
    } else {
      _repository.getByAccumulator<A>().applyBinary(fn, x, y);
    }
  }

  @override
  void run(Run fn) {
    if (_hasTransanction) {
      apply(fn);
    } else if (_canStartTransanction) {
      _executionZone.run(() {
        apply(fn);
      });
    }
  }

  @override
  void runUnary<X>(RunUnary<X> fn, X x) {
    if (_hasTransanction) {
      applyUnary(fn, x);
    } else if (_canStartTransanction) {
      _executionZone.run(() {
        applyUnary(fn, x);
      });
    }
  }

  @override
  void runBinary<X, Y>(RunBinary<X, Y> fn, X x, Y y) {
    if (_hasTransanction) {
      applyBinary(fn, x, y);
    } else if (_canStartTransanction) {
      _executionZone.run(() {
        applyBinary(fn, x, y);
      });
    }
  }

  Zone _createExecutionZone() {
    return Zone.current.fork(
      specification: ZoneSpecification(
        run: <R>(source, parent, zone, fn) {
          return _canStartTransanction
              ? _runTransanction(() => parent.run(zone, fn))
              : parent.run(zone, fn);
        },
        runUnary: <R, X>(source, parent, zone, fn, x) {
          return _canStartTransanction
              ? _runTransanction(() => parent.runUnary(zone, fn, x))
              : parent.runUnary(zone, fn, x);
        },
        runBinary: <R, X, Y>(source, parent, zone, fn, x, y) {
          return _canStartTransanction
              ? _runTransanction(() => parent.runBinary(zone, fn, x, y))
              : parent.runBinary(zone, fn, x, y);
        },
      ),
    );
  }

  T _runTransanction<T>(T Function() run) {
    _hasTransanction = true;
    final result = run();
    _repository.applyChanges();
    _hasTransanction = false;
    return result;
  }

  T _getTypedThis<T>() => this as T; // ignore: avoid_as
}
