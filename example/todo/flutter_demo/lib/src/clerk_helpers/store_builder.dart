import 'package:clerk/clerk.dart' show Store;
import 'package:flutter/widgets.dart';

import 'store_porter.dart';
import 'store_provider.dart';

class StoreBuilder extends StatefulWidget {
  const StoreBuilder({@required this.builder, Key key})
      : _getPorter = _getSyncPorter,
        super(key: key);

  const StoreBuilder.after({@required this.builder, Key key})
      : _getPorter = _getAfterPorter,
        super(key: key);

  final Widget Function(BuildContext, StorePorter) builder;

  final StorePorter Function(Store) _getPorter;

  static StorePorter _getSyncPorter(Store store) => StorePorter(store);
  static StorePorter _getAfterPorter(Store store) => StorePorter.after(store);

  @override
  _StoreBuilderState createState() => _StoreBuilderState();
}

class _StoreBuilderState extends State<StoreBuilder> {
  Store _store;
  StorePorter _porter;

  @override
  void didChangeDependencies() {
    _store = StoreProvider.of(context);
    _porter = widget._getPorter(_store);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _porter.teardown();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => StreamBuilder(
        stream: _porter.onChange,
        builder: (context, snapshot) => widget.builder(context, _porter),
      );
}
