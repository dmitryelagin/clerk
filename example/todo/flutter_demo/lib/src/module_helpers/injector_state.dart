import 'package:flutter/widgets.dart';

import 'injector.dart';
import 'injector_provider.dart';

mixin InjectorState<T extends StatefulWidget> on State<T> implements Injector {
  final _cache = <Type, Object>{};

  Injector _injector;

  @override
  bool get isEmpty => _injector.isEmpty;

  @override
  bool has<V>() => _cache[V] != null || _injector.has<V>();

  @override
  V get<V>() => _cast(_cache[V] ??= _injector.get<V>());

  @override
  V tryGet<V>() => _cast(_cache[V] ??= _injector.tryGet<V>());

  @override
  Iterable<V> getAll<V>() => _cast(_cache[V] ??= _injector.getAll<V>());

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _injector = InjectorProvider.of(context);
    _cache.clear();
  }

  V _cast<V>(Object value) => value as V; // ignore: avoid_as
}
