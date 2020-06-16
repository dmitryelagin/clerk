import 'dart:async';

typedef GetValue<T> = T Function();
typedef GetStream = Stream<T> Function<T>();
typedef GetStreamController = StreamController<T> Function<T>();
typedef ReadFallback = T Function<T>(Type, Type, [Object, Object]);
typedef WriteFallback = void Function(Type, [Object, Object]);
