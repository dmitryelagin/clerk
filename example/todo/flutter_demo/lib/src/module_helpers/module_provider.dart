import 'package:flutter/widgets.dart';

import 'locator_impl.dart';
import 'module.dart';
import 'module_null.dart';
import 'types.dart';

class ModuleProvider extends StatefulWidget {
  const ModuleProvider({
    @required this.initialize,
    @required this.child,
    Key key,
  }) : super(key: key);

  final InitializeInjector initialize;
  final Widget child;

  static Module of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_ModuleProvider>()?.module ??
      const ModuleNull();

  @override
  _ModuleProviderState createState() => _ModuleProviderState();
}

class _ModuleProviderState extends State<ModuleProvider> {
  LocatorImpl _locator;

  @override
  void initState() {
    super.initState();
    _initModule();
  }

  @override
  void didUpdateWidget(ModuleProvider previous) {
    super.didUpdateWidget(previous);
    _locator.reset();
    _initModule();
  }

  @override
  Widget build(BuildContext _) =>
      _ModuleProvider(module: _locator, child: widget.child);

  @override
  void dispose() {
    _locator.reset();
    super.dispose();
  }

  void _initModule() {
    _locator = LocatorImpl(parent: ModuleProvider.of(context));
    widget.initialize(_locator);
  }
}

class _ModuleProvider extends InheritedWidget {
  const _ModuleProvider({
    @required this.module,
    @required Widget child,
  }) : super(child: child);

  final Module module;

  @override
  bool updateShouldNotify(_ModuleProvider previous) => previous != this;
}
