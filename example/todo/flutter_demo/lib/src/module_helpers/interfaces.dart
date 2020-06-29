import 'types.dart';

abstract class Provider<T> {
  T getInstance(ResolveInstance resolve);
  void reset();
}

abstract class Module {
  T resolve<T>();
}

abstract class Injector {
  void registerSingleton<T>(
    CreateInstance<T> create, {
    ResetInstance<T> onReset,
  });

  void registerFactory<T>(
    CreateInstance<T> create, {
    ResetInstance<T> onReset,
  });

  void registerMimic<T, S extends T>();
  void register<T>(Provider<T> provider);
}
