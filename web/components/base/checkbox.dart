import 'dart:html';

import 'package:clerk/clerk.dart';

class Checkbox {
  factory Checkbox() => _lastInstance;

  Checkbox.create(this._execute) {
    _lastInstance = this;
  }

  static Checkbox _lastInstance;

  final Execute _execute;

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
        _execute(toggleAction(event));
      });
  }
}
