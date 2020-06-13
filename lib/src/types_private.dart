import 'dart:async';

typedef StreamFactory = Stream<T> Function<T>();
typedef StreamControllerFactory = StreamController<T> Function<T>();
typedef FallbackValueFactory = T Function<T>(Type, Type, [Object, Object]);
