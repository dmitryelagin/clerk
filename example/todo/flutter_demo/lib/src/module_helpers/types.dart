import 'locator.dart';

typedef CreateInstance<T> = T Function();
typedef ResetInstance<T> = void Function(T);
typedef InitializeLocator = void Function(Locator);
