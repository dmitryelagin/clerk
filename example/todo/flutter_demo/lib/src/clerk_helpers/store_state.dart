import 'dart:async';

import 'package:flutter/widgets.dart';

import 'store_porter.dart';
import 'store_provider.dart';

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
    final store = StoreProvider.of(context);
    _store = StorePorter(store.reader, store.executor, store.accessor);
    _subscription = _store.onAfterChanges.listen((event) {
      setState(_noop);
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _store?.teardown();
    super.dispose();
  }
}
