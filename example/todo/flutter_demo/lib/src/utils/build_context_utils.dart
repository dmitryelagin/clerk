import 'package:flutter/widgets.dart';
import 'package:flutter_demo/src/module_helpers/module.dart';

extension InjectBuildContextUtils on BuildContext {
  T resolve<T>() => ModuleProvider.of(this)?.resolve();
}
