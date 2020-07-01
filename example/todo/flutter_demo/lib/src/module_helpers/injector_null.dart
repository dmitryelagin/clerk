import 'injector.dart';

class InjectorNull extends Injector {
  const InjectorNull();

  @override
  bool get isEmpty => true;

  @override
  T tryGet<T>() => null;

  @override
  Iterable<T> getAll<T>() => const {};
}
