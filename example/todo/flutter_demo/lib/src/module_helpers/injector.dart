import 'providers.dart';
import 'types.dart';

abstract class Injector {
  void mapSingleton<T>(CreateInstance<T> create);
  void mapFactory<T>(CreateInstance<T> create);
  void mapMimic<T, S extends T>();
  void map<T>(Provider<T> provider);
}
