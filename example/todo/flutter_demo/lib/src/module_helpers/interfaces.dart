import 'injector.dart';
import 'types.dart';

abstract class Locator extends Injector {
  void bindSingleton<T>(
    CreateInstance<T> create, {
    ResetInstance<T> onReset,
  });

  void bindFactory<T>(
    CreateInstance<T> create, {
    ResetInstance<T> onReset,
  });

  void bind<T>(Provider<T> provider);
}

abstract class Provider<T extends Object> {
  T getInstance();
  void reset();
}
