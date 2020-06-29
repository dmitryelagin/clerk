import 'interfaces.dart';

typedef ResolveInstance = T Function<T>();
typedef CreateInstance<T> = T Function(ResolveInstance);
typedef ResetInstance<T> = void Function(T);
typedef InitializeInjector = void Function(Injector);
