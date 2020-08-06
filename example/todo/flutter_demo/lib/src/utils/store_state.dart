import 'dart:async';

import 'package:clerk/clerk.dart' show StoreManager;
import 'package:flutter/widgets.dart';
import 'package:summon/summon.dart';

import 'store_manager_wrapper.dart';

abstract class StoreState<T extends StatefulWidget> extends State<T> {
  StoreManagerWrapper _store;
  StreamSubscription<Object> _subscription;

  StoreManager get store => _store;

  bool get _isInitialized => _store != null && _subscription != null;

  static void _noop() {}

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInitialized) return;
    _store = StoreManagerWrapper(InjectorProvider.of(context).get());
    _subscription = _store.onChange.listen(_update);
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
