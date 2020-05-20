import 'dart:html';

import 'package:clerk/clerk.dart';

class Checkbox {
  factory Checkbox() => _lastInstance;

  Checkbox.create(this._executor) {
    _lastInstance = this;
  }

  static Checkbox _lastInstance;

  final StoreExecutor _executor;

  Element render({
    bool isChecked,
    Iterable<String> classes = const [],
    Action Function(Event) toggleAction,
  }) {
    final element = CheckboxInputElement()
      ..classes.addAll(classes)
      ..checked = isChecked;
    if (toggleAction == null) return element;
    return element
      ..onInput.listen((event) {
        _executor.execute(toggleAction(event));
      });
  }
}
