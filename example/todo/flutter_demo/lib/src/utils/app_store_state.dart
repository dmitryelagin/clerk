import 'package:flutter/widgets.dart';
import 'package:flutter_demo/src/clerk_helpers/clerk.dart';
import 'package:flutter_demo/src/module_helpers/module.dart';

abstract class AppStoreState<T extends StatefulWidget> extends StoreState<T> {
  AppStoreState() : super((context) => ModuleProvider.of(context).resolve());

  Module _module;

  Module get module => _module;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _module = ModuleProvider.of(context);
  }
}
