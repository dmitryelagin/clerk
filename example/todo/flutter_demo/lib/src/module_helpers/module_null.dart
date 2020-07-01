import 'module.dart';

class ModuleNull extends Module {
  const ModuleNull();

  @override
  bool get isEmpty => true;

  @override
  T tryResolve<T>() => null;

  @override
  Iterable<T> resolveAll<T>() => const {};
}
