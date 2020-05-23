import 'package:clerk/clerk.dart' hide State;
import 'package:flutter/widgets.dart';

import 'store_porter.dart';
import 'store_porter_impl.dart';
import 'store_provider.dart';
import 'store_trigger.dart';

class StoreBuilder extends StatefulWidget {
  const StoreBuilder({
    @required this.builder,
    this.trigger = StoreTrigger.sync,
    Key key,
  }) : super(key: key);

  final Widget Function(BuildContext, StorePorter) builder;
  final StoreTrigger trigger;

  @override
  _StoreBuilderState createState() => _StoreBuilderState();
}

class _StoreBuilderState extends State<StoreBuilder> {
  Store _store;
  StorePorterImpl _porter;

  @override
  void initState() {
    _store = StoreProvider.of(context);
    _porter = StorePorterImpl(_store, widget.trigger);
    super.initState();
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
