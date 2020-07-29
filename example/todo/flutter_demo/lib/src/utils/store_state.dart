import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:summon/summon.dart';

import 'store_porter.dart';

abstract class StoreState<T extends StatefulWidget> extends State<T> {
  StorePorter _store;
  StreamSubscription<Object> _subscription;

  StorePorter get store => _store;

  bool get _isInitialized => _store != null && _subscription != null;

  static void _noop() {}

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInitialized) return;
    _store = StorePorter(InjectorProvider.of(context).get());
    _subscription = _store.onAfterChanges.listen(_update);
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _store?.teardown();
    super.dispose();
  }

  void _update(Object _) {
    setState(_noop);
  }
}
