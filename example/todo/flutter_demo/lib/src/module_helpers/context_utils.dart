import 'package:flutter/widgets.dart';

import 'module_builder.dart';

extension InjectBuildContextUtils on BuildContext {
  T get<T>() => ModuleBuilder.get(this);
}
