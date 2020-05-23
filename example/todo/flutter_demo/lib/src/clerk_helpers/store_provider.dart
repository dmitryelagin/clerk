import 'package:clerk/clerk.dart' hide State;
import 'package:flutter/widgets.dart';

class StoreProvider extends StatefulWidget {
  const StoreProvider({
    @required this.child,
    this.store,
    Key key,
  }) : super(key: key);

  static Store of(BuildContext context) =>
      context.findAncestorWidgetOfExactType<StoreProvider>()?.store;

  final Widget child;
  final Store store;

  @override
  _StoreProviderState createState() => _StoreProviderState();
}

class _StoreProviderState extends State<StoreProvider> {
  @override
  void dispose() {
    widget.store.teardown();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
