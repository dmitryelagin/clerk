/// A marker interface implemented by all state exceptions.
abstract class StateException implements Exception {}

/// Exception thrown when specific model changes can not be listened.
///
/// This can happen because there is no appropriate state was found. Add state
/// to store before listening its model changes. This exception can be
/// influenced by changing store behavior with settings.
class ListenChangeException implements StateException {
  /// Creates a new [ListenChangeException].
  const ListenChangeException(this.targetType);

  /// The type of model that is attempted to be listened.
  final Type targetType;

  @override
  String toString() => 'ListenChangeException: '
      'Failed to listen $targetType model changes - appropriate '
      'state was not found.';
}

/// Exception thrown when specific read operation can not be executed.
///
/// This can happen because there is no required state model was found.
/// Add state to store before reading from its model. This exception can be
/// influenced by changing store behavior with settings.
class ReadException implements StateException {
  /// Creates a new [ReadException].
  const ReadException(this.targetType);

  /// The type of model that is required to read.
  final Type targetType;

  @override
  String toString() => 'ReadException: '
      'Failed to read from $targetType - appropriate '
      'state or type was not found.';
}

/// Exception thrown when specific apply operation can not be executed.
///
/// This can happen because there is no required state accumulator was found.
/// Add state to store before writing to its accumulator. This exception can
/// be influenced by changing store behavior with settings.
class ApplyException implements StateException {
  /// Creates a new [ApplyException].
  const ApplyException(this.targetType);

  /// The type of accumulator that is required to apply.
  final Type targetType;

  @override
  String toString() => 'ApplyException: '
      'Failed to apply to $targetType - appropriate '
      'state or type was not found.';
}

/// Exception thrown when specific apply operation can not be executed.
///
/// This can happen because some apply operation was started outside of store
/// execution zone. Execute apply operations only by store `apply*` methods,
/// this helps store to properly handle possible changes in async operations.
class WrongZoneApplyException implements StateException {
  /// Creates a new [WrongZoneApplyException].
  const WrongZoneApplyException();

  @override
  String toString() => 'WrongZoneApplyException: '
      'Failed to apply - operation started outside of store execution zone.';
}
