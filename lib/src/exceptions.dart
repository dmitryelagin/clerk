abstract class StateException implements Exception {}

class ListenChangeException implements StateException {
  const ListenChangeException(this.targetType);

  final Type targetType;

  @override
  String toString() => 'ListenChangeException: '
      'Failed to listen $targetType model changes'
      ' - appropriate state was not found.';
}

class EvaluationException implements StateException {
  const EvaluationException(
    this.targetType,
    this.resultType, [
    this.firstArgument,
    this.secondArgument,
  ]);

  final Type targetType;
  final Type resultType;
  final Object firstArgument;
  final Object secondArgument;

  @override
  String toString() => 'EvaluationException: '
      'Failed to get $resultType value from $targetType model'
      '${firstArgument == null ? '' : ', first argument: $firstArgument'}'
      '${secondArgument == null ? '' : ', second argument: $secondArgument'}'
      ' - appropriate state was not found.';
}

class AssignmentException implements StateException {
  const AssignmentException(
    this.targetType,
    this.resultType, [
    this.firstArgument,
    this.secondArgument,
  ]);

  final Type targetType;
  final Type resultType;
  final Object firstArgument;
  final Object secondArgument;

  @override
  String toString() => 'AssignmentException: '
      'Failed to modify $targetType accumulator'
      '${firstArgument == null ? '' : ', first argument: $firstArgument'}'
      '${secondArgument == null ? '' : ', second argument: $secondArgument'}'
      ' - appropriate state was not found.';
}
