import 'package:flutter/widgets.dart';

import 'interfaces.dart';
import 'locator.dart';
import 'types.dart';

class ModuleProvider extends StatefulWidget {
  ModuleProvider({
    @required Iterable<Initialize> initializers,
    @required this.builder,
    Key key,
  }) : super(key: key) {
    for (final initialize in initializers) {
      initialize(_locator);
    }
  }

  final Widget Function(BuildContext) builder;

  final Locator _locator = Locator();

  static Module of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_ModuleProvider>()?.module;

  @override
  _ModuleProviderState createState() => _ModuleProviderState();
}

class _ModuleProviderState extends State<ModuleProvider> {
  @override
  void dispose() {
    widget._locator.reset();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => _ModuleProvider.from(widget);
}

class _ModuleProvider extends InheritedWidget {
  _ModuleProvider.from(ModuleProvider widget)
      : module = widget._locator,
        super(child: _ModuleProviderBuilder.from(widget), key: widget.key);

  final Module module;

  @override
  bool updateShouldNotify(_ModuleProvider oldWidget) => oldWidget != this;
}

class _ModuleProviderBuilder extends StatelessWidget {
  _ModuleProviderBuilder.from(ModuleProvider widget)
      : _builder = widget.builder,
        super(key: widget.key);

  final WidgetBuilder _builder;

  @override
  Widget build(BuildContext context) => _builder(context);
}
