import 'injector.dart';

typedef GetInstance = T Function<T>();
typedef CreateInstance<T> = T Function(GetInstance);
typedef Initialize = void Function(Injector);
