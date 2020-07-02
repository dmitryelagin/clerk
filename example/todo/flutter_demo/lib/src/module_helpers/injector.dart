import 'errors.dart';

abstract class Injector {
  const Injector();

  bool get isEmpty;

  bool has<T>() => tryGet<T>() != null;

  T get<T>() {
    final result = tryGet<T>();
    if (result != null) return result;
    throw DependencyNotFoundError(T);
  }

  T tryGet<T>();
  Iterable<T> getAll<T>();
}
