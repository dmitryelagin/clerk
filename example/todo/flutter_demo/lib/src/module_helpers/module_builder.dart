import 'package:flutter/widgets.dart';

import 'locator.dart';
import 'types.dart';

class ModuleBuilder extends StatefulWidget {
  ModuleBuilder({
    @required Iterable<Initialize> initializers,
    @required this.builder,
    Key key,
  }) : super(key: key) {
    for (final initialize in initializers) {
      initialize(_injector);
    }
  }

  final Widget Function(BuildContext) builder;

  final Locator _injector = Locator();

  static T get<T>(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_ModuleProvider>()?.get();

  @override
  _ModuleBuilderState createState() => _ModuleBuilderState();
}

class _ModuleBuilderState extends State<ModuleBuilder> {
  @override
  void dispose() {
    widget._injector.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => _ModuleProvider.from(widget);
}

class _ModuleProvider extends InheritedWidget {
  _ModuleProvider.from(ModuleBuilder widget)
      : _injector = widget._injector,
        super(child: _ModuleBuilder.from(widget), key: widget.key);

  final Locator _injector;

  T get<T>() => _injector.get();

  @override
  bool updateShouldNotify(_ModuleProvider oldWidget) => oldWidget != this;
}

class _ModuleBuilder extends StatelessWidget {
  _ModuleBuilder.from(ModuleBuilder widget)
      : _builder = widget.builder,
        super(key: widget.key);

  final Widget Function(BuildContext) _builder;

  @override
  Widget build(BuildContext context) => _builder(context);
}
