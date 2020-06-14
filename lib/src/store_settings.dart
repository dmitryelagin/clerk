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
    GetStreamController getStreamController = _streamControllerFactory,
    GetStream onListenChangeFailed = _listenChangeFallback,
    ReadFallback onReadFailed = _readFallback,
    WriteFallback onWriteFailed = _writeFallback,
  })  : _getStreamController = getStreamController,
        _onListenChangeFailed = onListenChangeFailed,
        _onReadFailed = onReadFailed,
        _onWriteFailed = onWriteFailed;

  final GetStreamController _getStreamController;
  final GetStream _onListenChangeFailed;
  final ReadFallback _onReadFailed;
  final WriteFallback _onWriteFailed;

  static StreamController<T> _streamControllerFactory<T>() =>
      StreamController.broadcast(sync: true);

  static Stream<T> _listenChangeFallback<T>() {
    throw ListenChangeException(T);
  }

  static T _readFallback<T>(Type m, Type v, [Object? x, Object? y]) {
    throw ReadException(m, v, x, y);
  }

  static void _writeFallback(Type a, [Object? x, Object? y]) {
    throw WriteException(a, x, y);
  }

  /// Creates [StreamController] for store internal usage.
  ///
  /// This method will be called during store initialization to produce
  /// [StreamController]s for standard notifications like `onBeforeAction`
  /// stream in accessor, then  every time the new state is added to store
  /// to produce [StreamController]s for specific state notifications like
  /// `onAfterChanges` stream. Returns [StreamController.broadcast(sync: true)]
  /// by default.
  StreamController<T> getStreamController<T>() => _getStreamController();

  /// Handles model changes listening failure.
  ///
  /// This method is called every time when specific model is failed to be
  /// listened because no appropriate state was found. It should return
  /// [Stream] with such model changes to continue execution. Throws
  /// [ListenChangeException] by default.
  Stream<T> onListenChangeFailed<T>() => _onListenChangeFailed();

  /// Handles reading failure.
  ///
  /// This method is called every time when read operation failed because
  /// no state with required model was found. It should return proper value
  /// to continue execution. Throws [ReadException] by default.
  T onReadFailed<T>(Type m, Type v, [Object? x, Object? y]) =>
      _onReadFailed(m, v, x, y);

  /// Handles writing failure.
  ///
  /// This method is called every time when write operation failed because
  /// no state with required accumulator was found. It should not throw
  /// to continue execution. Throws [WriteException] by default.
  void onWriteFailed(Type a, [Object? x, Object? y]) => _onWriteFailed(a, x, y);
}
