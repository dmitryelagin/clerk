import 'dart:async';

import 'exceptions.dart';
import 'types_private.dart';

/// An object that can influence some store behavior.
///
/// It helps to control exceptions handling and to create customized
/// stream-related objects.
class StoreSettings {
  /// Creates a [StoreSettings] object from simple callbacks.
  ///
  /// Provide callbacks with the same names as [StoreSettings]'s own methods
  /// to simply override corresponding behaviors.
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

  /// Creates [StreamController] for store internal usage.
  ///
  /// This method will be called during store initialization to produce
  /// [StreamController]s for standard notifications like `onBeforeAction`
  /// stream in accessor, then  every time the new state is added to store
  /// to produce [StreamController]s for specific state notifications like
  /// `onAfterChanges` stream. Returns [StreamController.broadcast(sync: true)]
  /// by default.
  StreamController<T> createStreamController<T>() => _createStreamController();

  /// Handles model changes listening failure.
  ///
  /// This method is called every time when specific model is failed to be
  /// listened because no appropriate state was found. It should return
  /// [Stream] with such model changes to continue execution. Throws
  /// [ListenChangeException] by default.
  Stream<T> onListenChangeFailed<T>() => _onListenChangeFailed();

  /// Handles selector evaluation failure.
  ///
  /// This method is called every time when specific selector is failed to
  /// be evaluated because no state with required model was found. It should
  /// return proper value to continue execution. Throws [EvaluationException]
  /// by default.
  T onEvaluationFailed<T>(Type m, Type v, [Object x, Object y]) =>
      _onEvaluationFailed(m, v, x, y);

  /// Handles assignment failure.
  ///
  /// This method is called every time when specific writer is failed to
  /// be assign value to accumulator because no appropriate state was found.
  /// It should return proper value to continue execution. Throws
  /// [AssignmentException] by default.
  T onAssignmentFailed<T>(Type a, Type v, [Object x, Object y]) =>
      _onAssignmentFailed(a, v, x, y);
}
