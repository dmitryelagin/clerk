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
      'Failed to listen $targetType model changes'
      ' - appropriate state was not found.';
}

/// Exception thrown when specific read operation can not be executed.
///
/// This can happen because there is no required state model was found.
/// Add state to store before reading from its model. This exception can be
/// influenced by changing store behavior with settings.
class ReadException implements StateException {
  /// Creates a new [ReadException].
  const ReadException(
    this.targetType,
    this.resultType, [
    this.firstArgument,
    this.secondArgument,
  ]);

  /// The type of model that is required to read.
  final Type targetType;

  /// The type of value that should be returned after reading.
  final Type resultType;

  /// The optionaly provided first argument.
  final Object firstArgument;

  /// The optionaly provided second argument.
  final Object secondArgument;

  @override
  String toString() => 'ReadException: '
      'Failed to read $resultType value from $targetType model'
      '${firstArgument == null ? '' : ', first argument: $firstArgument'}'
      '${secondArgument == null ? '' : ', second argument: $secondArgument'}'
      ' - appropriate state was not found.';
}

/// Exception thrown when specific write operation can not be executed.
///
/// This can happen because there is no required state accumulator was found.
/// Add state to store before writing to its accumulator. This exception can
/// be influenced by changing store behavior with settings.
class WriteException implements StateException {
  /// Creates a new [WriteException].
  const WriteException(
    this.targetType, [
    this.firstArgument,
    this.secondArgument,
  ]);

  /// The type of accumulator that is required to write.
  final Type targetType;

  /// The optionaly provided first argument.
  final Object firstArgument;

  /// The optionaly provided second argument.
  final Object secondArgument;

  @override
  String toString() => 'WriteException: '
      'Failed to write to $targetType accumulator'
      '${firstArgument == null ? '' : ', first argument: $firstArgument'}'
      '${secondArgument == null ? '' : ', second argument: $secondArgument'}'
      ' - appropriate state was not found.';
}
