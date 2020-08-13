import 'dart:async';

import 'exceptions.dart';

/// An object that can influence some store behavior.
///
/// It helps to control exceptions handling and to create customized
/// stream-related objects.
class StoreSettings<S extends Object> {
  /// Creates a [StoreSettings] object from simple callbacks.
  ///
  /// Provide callbacks with the same names as [StoreSettings]'s own methods
  /// to simply override corresponding behaviors.
  const StoreSettings(
    this.getStateAggregate, {
    this.getStreamController = _getStreamController,
    this.getModelChangeFallback = _onListenChangeFailed,
    this.getModelFallback = _onReadFailed,
    this.getAccumulatorFallback = _onApplyFailed,
  });

  /// The default settings for store with simplified `onChange` [Stream].
  ///
  /// The `onChange` [Stream] will always return blank [Object] as a
  /// state aggregate.
  static final standard = StoreSettings((_) => Object());

  /// Creates state object from all models available in store.
  ///
  /// This will be called when store needs to map all models to a state
  /// aggregate, probably when the main `onChange` stream is listened or
  /// when `state` getter is called. Function will be provided with the
  /// callback that returns a map of all available models as values and their
  /// corresponding types as keys.
  final S Function(Map<Type, Object?> Function()) getStateAggregate;

  /// Creates [StreamController] for store internal usage.
  ///
  /// This will be called during store initialization to produce
  /// [StreamController]s for standard notifications like main `onChange`
  /// stream in accessor, then every time the new state is added to store to
  /// produce [StreamController]s for specific state notifications like thier
  /// own `onChange` streams. Returns `StreamController.broadcast(sync: true)`
  /// by default.
  final StreamController<T> Function<T>() getStreamController;

  /// Handles model changes listening failure.
  ///
  /// This is called every time when specific model is failed to be
  /// listened because no appropriate state was found. It should return
  /// [Stream] with such model changes to continue execution. Throws
  /// [ListenChangeException] by default.
  final Stream<T> Function<T>() getModelChangeFallback;

  /// Handles reading failure.
  ///
  /// This is called every time when read operation failed because
  /// no state with required model was found. It should return proper model
  /// to continue execution. Throws [ReadException] by default.
  final T Function<T>() getModelFallback;

  /// Handles applying failure.
  ///
  /// This is called every time when apply operation failed because
  /// no state with required accumulator was found. It should return proper
  /// accumulator to continue execution. Throws [ApplyException] by default.
  final T Function<T>() getAccumulatorFallback;

  static StreamController<T> _getStreamController<T>() =>
      StreamController.broadcast(sync: true);

  static Stream<T> _onListenChangeFailed<T>() {
    throw ListenChangeException(T);
  }

  static T _onReadFailed<T>() {
    throw ReadException(T);
  }

  static T _onApplyFailed<T>() {
    throw ApplyException(T);
  }
}
