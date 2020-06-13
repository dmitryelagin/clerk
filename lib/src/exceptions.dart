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

/// Exception thrown when specific selector can not be executed.
///
/// This can happen because there is no required state model was found.
/// Add state to store before evaluating its model. This exception can be
/// influenced by changing store behavior with settings.
class EvaluationException implements StateException {
  /// Creates a new [EvaluationException].
  const EvaluationException(
    this.targetType,
    this.resultType, [
    this.firstArgument,
    this.secondArgument,
  ]);

  /// The type of model that selector requires.
  final Type targetType;

  /// The type of value that selector returns.
  final Type resultType;

  /// The optional first argument provided to selector.
  final Object firstArgument;

  /// The optional second argument provided to selector.
  final Object secondArgument;

  @override
  String toString() => 'EvaluationException: '
      'Failed to get $resultType value from $targetType model'
      '${firstArgument == null ? '' : ', first argument: $firstArgument'}'
      '${secondArgument == null ? '' : ', second argument: $secondArgument'}'
      ' - appropriate state was not found.';
}

/// Exception thrown when specific writer can not be executed.
///
/// This can happen because there is no required state accumulator was found.
/// Add state to store before writing to its accumulator. This exception can
/// be influenced by changing store behavior with settings.
class AssignmentException implements StateException {
  /// Creates a new [AssignmentException].
  const AssignmentException(
    this.targetType,
    this.resultType, [
    this.firstArgument,
    this.secondArgument,
  ]);

  /// The type of accumulator that writer requires.
  final Type targetType;

  /// The type of value that writer returns.
  final Type resultType;

  /// The optional first argument provided to writer.
  final Object firstArgument;

  /// The optional second argument provided to writer.
  final Object secondArgument;

  @override
  String toString() => 'AssignmentException: '
      'Failed to modify $targetType accumulator'
      '${firstArgument == null ? '' : ', first argument: $firstArgument'}'
      '${secondArgument == null ? '' : ', second argument: $secondArgument'}'
      ' - appropriate state was not found.';
}
