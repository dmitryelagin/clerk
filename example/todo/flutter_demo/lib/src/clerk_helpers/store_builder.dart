import 'package:clerk/clerk.dart' show Store, StorePorter;
import 'package:flutter/widgets.dart';

import 'store_provider.dart';

class StoreBuilder extends StatefulWidget {
  const StoreBuilder({@required this.builder, Key key})
      : _createPorter = _createSyncPorter,
        super(key: key);

  const StoreBuilder.after({@required this.builder, Key key})
      : _createPorter = _createAfterPorter,
        super(key: key);

  final Widget Function(BuildContext, StorePorter) builder;

  final StorePorter Function(Store) _createPorter;

  static StorePorter _createSyncPorter(Store store) =>
      StorePorter(store.evaluator, store.executor, store.accessor);

  static StorePorter _createAfterPorter(Store store) =>
      StorePorter.after(store.evaluator, store.executor, store.accessor);

  @override
  _StoreBuilderState createState() => _StoreBuilderState();
}

class _StoreBuilderState extends State<StoreBuilder> {
  Store _store;
  StorePorter _porter;

  @override
  void didChangeDependencies() {
    _store = StoreProvider.of(context);
    _porter = widget._createPorter(_store);
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
