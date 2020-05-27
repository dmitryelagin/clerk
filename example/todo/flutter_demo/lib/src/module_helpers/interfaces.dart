import 'types.dart';

abstract class Provider<T> {
  T getInstance(ResolveInstance resolve);
}

abstract class Module {
  T resolve<T>();
}

abstract class Injector {
  void registerSingleton<T>(CreateInstance<T> create);
  void registerFactory<T>(CreateInstance<T> create);
  void registerMimic<T, S extends T>();
  void register<T>(Provider<T> provider);
}
