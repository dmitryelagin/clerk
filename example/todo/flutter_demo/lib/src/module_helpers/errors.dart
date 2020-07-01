class DependencyNotFoundError extends StateError {
  DependencyNotFoundError(this.targetType) : super(_getMessage(targetType));

  final Type targetType;

  static String _getMessage(Type targetType) =>
      'Dependency with type ${targetType.toString()} was not found in '
      'available injectors. This error occurs when dependency was not '
      'registered or the widgets hierarchy has not have InjectorProvider '
      'for required injector.';
}
