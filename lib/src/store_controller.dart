import 'dart:async';

import 'action.dart';
import 'interfaces_public.dart';
import 'state.dart';
import 'state_repository.dart';
import 'types_private.dart';

class StoreController implements StoreComposer, StoreExecutor {
  StoreController(this._innerExecutor, this._repository) {
    _executionZone = _createExecutionZone();
  }

  final StoreExecutor _innerExecutor;
  final StateRepository _repository;

  late Zone _executionZone;

  var _hasTransanction = false;

  bool get _canNotStartTransanction =>
      _hasTransanction || _repository.isTeardowned;

  @override
  void add<M, A>(State<M, A> state) {
    if (_canNotStartTransanction) return;
    _repository.add(state);
  }

  @override
  Future<void> remove<M>() {
    if (_canNotStartTransanction) return Future.value();
    return _repository.remove<M>();
  }

  @override
  void execute(Action action) {
    if (_repository.isTeardowned) return;
    _executionZone.runUnary(_innerExecutor.execute, action);
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
    _repository.checkChanges();
    _hasTransanction = false;
    return result;
  }
}
