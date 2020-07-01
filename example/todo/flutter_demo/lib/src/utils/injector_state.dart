import 'package:flutter/widgets.dart';
import 'package:flutter_demo/src/module_helpers/index.dart';
import 'package:flutter_demo/src/utils/store_state.dart';

abstract class InjectorState<T extends StatefulWidget> extends StoreState<T> {
  InjectorState() : super((context) => InjectorProvider.of(context).get());

  final _cache = <Type, Object>{};

  Injector _injector;

  V resolve<V>() => _cast(_cache[V] ??= _injector.get<V>());
  V tryResolve<V>() => _cast(_cache[V] ??= _injector.tryGet<V>());
  Iterable<V> resolveAll<V>() => _cast(_cache[V] ??= _injector.getAll<V>());

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _injector = InjectorProvider.of(context);
    _cache.clear();
  }

  V _cast<V>(Object value) => value as V; // ignore: avoid_as
}
