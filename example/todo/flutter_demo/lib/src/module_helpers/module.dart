import 'errors.dart';

abstract class Module {
  const Module();

  bool get isEmpty;

  T resolve<T>() {
    final result = tryResolve<T>();
    if (result != null) return result;
    throw DependencyNotFoundError(T);
  }

  T tryResolve<T>();
  Iterable<T> resolveAll<T>();
}
