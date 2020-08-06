import 'dart:async';

import 'interfaces.dart';
import 'store_repository.dart';
import 'types.dart';

class StoreExecutorImpl implements StoreExecutor {
  StoreExecutorImpl(this._repository, this._innerExecutor, this._helper) {
    _executionZoneSpecification = _createExecutionZoneSpecification();
  }

  final StoreRepository _repository;
  final StoreExecutor _innerExecutor;
  final ExecutionHelper _helper;

  ZoneSpecification _executionZoneSpecification;

  var _hasTransanction = false;

  @override
  void apply<A>(Apply<A> fn) {
    _runZoned(() {
      _innerExecutor.apply(fn);
    });
  }

  @override
  void applyUnary<A, X>(ApplyUnary<A, X> fn, X x) {
    _runZoned(() {
      _innerExecutor.applyUnary(fn, x);
    });
  }

  @override
  void applyBinary<A, X, Y>(ApplyBinary<A, X, Y> fn, X x, Y y) {
    _runZoned(() {
      _innerExecutor.applyBinary(fn, x, y);
    });
  }

  void _runZoned(void Function() fn) {
    if (_hasTransanction) {
      fn();
    } else {
      _helper.run(fn, zoneSpecification: _executionZoneSpecification);
    }
  }

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
    _helper.run(_repository.applyChanges, source: source);
    _hasTransanction = false;
    return result;
  }
}
