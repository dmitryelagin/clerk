import 'injector.dart';
import 'provider.dart';
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
