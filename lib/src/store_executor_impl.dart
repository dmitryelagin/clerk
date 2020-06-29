import 'dart:async';

import 'interfaces_public.dart';
import 'state_repository.dart';
import 'types_private.dart';
import 'types_public.dart';

class StoreExecutorImpl implements StoreExecutor {
  StoreExecutorImpl(this._repository, this._innerExecutor) {
    _executionZone = _createExecutionZone();
  }

  final StateRepository _repository;
  final StoreExecutor _innerExecutor;

  late Zone _executionZone;

  var _hasTransanction = false;

  bool get _canNotStartTransanction =>
      _hasTransanction || _repository.isTeardowned;

  @override
  void execute(Execute fn) {
    if (_canNotStartTransanction) return;
    _executionZone.run(() {
      _innerExecutor.execute(fn);
    });
  }

  @override
  void executeUnary<X>(ExecuteUnary<X> fn, X x) {
    if (_canNotStartTransanction) return;
    _executionZone.run(() {
      _innerExecutor.executeUnary(fn, x);
    });
  }

  @override
  void executeBinary<X, Y>(ExecuteBinary<X, Y> fn, X x, Y y) {
    if (_canNotStartTransanction) return;
    _executionZone.run(() {
      _innerExecutor.executeBinary(fn, x, y);
    });
  }

  Zone _createExecutionZone() {
    return Zone.current.fork(
      specification: ZoneSpecification(
        run: <R>(source, parent, zone, fn) {
          return _canNotStartTransanction
              ? parent.run(zone, fn)
              : _runTransanction(() => parent.run(zone, fn));
        },
        runUnary: <R, X>(source, parent, zone, fn, x) {
          return _canNotStartTransanction
              ? parent.runUnary(zone, fn, x)
              : _runTransanction(() => parent.runUnary(zone, fn, x));
        },
        runBinary: <R, X, Y>(source, parent, zone, fn, x, y) {
          return _canNotStartTransanction
              ? parent.runBinary(zone, fn, x, y)
              : _runTransanction(() => parent.runBinary(zone, fn, x, y));
        },
      ),
    );
  }

  T _runTransanction<T>(GetValue<T> run) {
    _hasTransanction = true;
    final result = run();
    _repository.applyChanges();
    _hasTransanction = false;
    return result;
  }
}
