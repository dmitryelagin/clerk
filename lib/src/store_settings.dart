import 'dart:async';

import 'exceptions.dart';
import 'types_private.dart';

class StoreSettings {
  const StoreSettings({
    StreamControllerFactory createStreamController = _streamControllerFactory,
    StreamFactory onListenChangeFailed = _listenChangeFallback,
    FallbackValueFactory onEvaluationFailed = _evaluationFallback,
    FallbackValueFactory onAssignmentFailed = _assignmentFallback,
  })  : _createStreamController = createStreamController,
        _onListenChangeFailed = onListenChangeFailed,
        _onEvaluationFailed = onEvaluationFailed,
        _onAssignmentFailed = onAssignmentFailed;

  final StreamControllerFactory _createStreamController;
  final StreamFactory _onListenChangeFailed;
  final FallbackValueFactory _onEvaluationFailed;
  final FallbackValueFactory _onAssignmentFailed;

  static StreamController<T> _streamControllerFactory<T>() =>
      StreamController.broadcast(sync: true);

  static Stream<T> _listenChangeFallback<T>() {
    throw ListenChangeException(T);
  }

  static T _evaluationFallback<T>(Type m, Type v, [Object x, Object y]) {
    throw EvaluationException(m, v, x, y);
  }

  static T _assignmentFallback<T>(Type a, Type v, [Object x, Object y]) {
    throw AssignmentException(a, v, x, y);
  }

  StreamController<T> createStreamController<T>() => _createStreamController();

  Stream<T> onListenChangeFailed<T>() => _onListenChangeFailed();

  T onEvaluationFailed<T>(Type m, Type v, [Object x, Object y]) =>
      _onEvaluationFailed(m, v, x, y);

  T onAssignmentFailed<T>(Type a, Type v, [Object x, Object y]) =>
      _onAssignmentFailed(a, v, x, y);
}
