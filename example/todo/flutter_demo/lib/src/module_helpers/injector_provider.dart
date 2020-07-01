import 'package:flutter/widgets.dart';

import 'injector.dart';
import 'injector_null.dart';
import 'locator_impl.dart';
import 'types.dart';

class InjectorProvider extends StatefulWidget {
  const InjectorProvider({
    @required this.initialize,
    @required this.child,
    Key key,
  }) : super(key: key);

  final InitializeLocator initialize;
  final Widget child;

  static Injector of(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<_InjectorProvider>();
    return provider?.injector ?? const InjectorNull();
  }

  @override
  _InjectorProviderState createState() => _InjectorProviderState();
}

class _InjectorProviderState extends State<InjectorProvider> {
  LocatorImpl _locator;

  @override
  void initState() {
    super.initState();
    _initializeLocator();
  }

  @override
  void didUpdateWidget(InjectorProvider previous) {
    super.didUpdateWidget(previous);
    _locator.reset();
    _initializeLocator();
  }

  @override
  Widget build(BuildContext _) =>
      _InjectorProvider(injector: _locator, child: widget.child);

  @override
  void dispose() {
    _locator.reset();
    super.dispose();
  }

  void _initializeLocator() {
    _locator = LocatorImpl(parent: InjectorProvider.of(context));
    widget.initialize(_locator);
    _locator.initialize();
  }
}

class _InjectorProvider extends InheritedWidget {
  const _InjectorProvider({
    @required this.injector,
    @required Widget child,
  }) : super(child: child);

  final Injector injector;

  @override
  bool updateShouldNotify(_InjectorProvider previous) => previous != this;
}
