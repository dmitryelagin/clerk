import 'dart:async';

import 'interfaces.dart';
import 'store_repository.dart';
import 'types.dart';

class StoreExecutorImpl implements StoreExecutor {
  StoreExecutorImpl(this._repository, this._manager) {
    _executionZone = _createExecutionZone();
  }

  final StoreRepository _repository;
  final StoreManager _manager;

  Zone _executionZone;

  var _hasTransanction = false;

  bool get _canStartTransanction =>
      !_hasTransanction && !_repository.isTeardowned;

  @override
  void run(Run fn) {
    _runZoned(() {
      _manager.apply(fn);
    });
  }

  @override
  void runUnary<X>(RunUnary<X> fn, X x) {
    _runZoned(() {
      _manager.applyUnary(fn, x);
    });
  }

  @override
  void runBinary<X, Y>(RunBinary<X, Y> fn, X x, Y y) {
    _runZoned(() {
      _manager.applyBinary(fn, x, y);
    });
  }

  void _runZoned(void Function() fn) {
    if (_hasTransanction) {
      fn();
    } else if (_canStartTransanction) {
      _executionZone.run(fn);
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
}
