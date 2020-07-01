import 'package:flutter/widgets.dart';
import 'package:flutter_demo/src/module_helpers/index.dart';
import 'package:flutter_demo/src/utils/store_state.dart';

abstract class InjectorState<T extends StatefulWidget> extends StoreState<T> {
  InjectorState() : super((context) => InjectorProvider.of(context).get());

  Injector _injector;

  Injector get injector => _injector;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _injector = InjectorProvider.of(context);
  }
}
