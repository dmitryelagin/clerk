import 'interfaces.dart';

typedef ResolveInstance = T Function<T>();
typedef CreateInstance<T> = T Function(ResolveInstance);
typedef Initialize = void Function(Injector);
