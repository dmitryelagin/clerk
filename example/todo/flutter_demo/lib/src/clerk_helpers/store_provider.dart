import 'package:clerk/clerk.dart' hide State;
import 'package:flutter/widgets.dart';

class StoreProvider extends StatefulWidget {
  const StoreProvider({
    @required this.child,
    this.store,
    Key key,
  }) : super(key: key);

  final Widget child;
  final Store store;

  static Store of(BuildContext context) =>
      context.findAncestorWidgetOfExactType<StoreProvider>()?.store;

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
