import 'module.dart';
import 'types.dart';

abstract class Locator implements Module {
  void registerSingleton<T>(
    CreateInstance<T> create, {
    ResetInstance<T> onReset,
  });

  void registerFactory<T>(
    CreateInstance<T> create, {
    ResetInstance<T> onReset,
  });

  void register<T>(Provider<T> provider);
}

abstract class Provider<T extends Object> {
  T getInstance();
  void reset();
}
