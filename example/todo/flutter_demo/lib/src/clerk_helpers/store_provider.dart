import 'package:clerk/clerk.dart' show Store;
import 'package:flutter/widgets.dart';

class StoreProvider extends StatefulWidget {
  const StoreProvider({@required this.child, @required Store store, Key key})
      : _store = store,
        super(key: key);

  final Widget child;

  final Store _store;

  static Store of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_StoreProvider>()?.store;

  @override
  _StoreProviderState createState() => _StoreProviderState();
}

class _StoreProviderState extends State<StoreProvider> {
  @override
  void dispose() {
    widget._store.teardown();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => _StoreProvider.from(widget);
}

class _StoreProvider extends InheritedWidget {
  _StoreProvider.from(StoreProvider widget)
      : store = widget._store,
        super(child: widget.child, key: widget.key);

  final Store store;

  @override
  bool updateShouldNotify(_StoreProvider oldWidget) => oldWidget != this;
}
