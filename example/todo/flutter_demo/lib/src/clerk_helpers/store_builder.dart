import 'package:clerk/clerk.dart' show Store;
import 'package:flutter/widgets.dart';

import 'store_porter.dart';
import 'store_provider.dart';

class StoreBuilder extends StatefulWidget {
  const StoreBuilder({@required this.builder, Key key}) : super(key: key);

  final Widget Function(BuildContext, StorePorter) builder;

  @override
  _StoreBuilderState createState() => _StoreBuilderState();
}

class _StoreBuilderState extends State<StoreBuilder> {
  Store _store;
  StorePorter _porter;

  @override
  void didChangeDependencies() {
    _store = StoreProvider.of(context);
    _porter = StorePorter(_store.evaluator, _store.executor, _store.accessor);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _porter.teardown();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _porter.onChange,
      builder: (context, snapshot) => widget.builder(context, _porter),
    );
  }
}
