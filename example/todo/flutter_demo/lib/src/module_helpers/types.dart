import 'interfaces.dart';

typedef CreateInstance<T> = T Function();
typedef ResetInstance<T> = void Function(T);
typedef InitializeInjector = void Function(Locator);
