import 'dart:html';

import 'package:clerk/clerk.dart';

class Input {
  factory Input() => _lastInstance;

  Input.create(this._execute) {
    _lastInstance = this;
  }

  static Input _lastInstance;

  final Execute _execute;

  Element render(
    String value, {
    bool isAutofocused = false,
    Iterable<String> classes = const [],
    Action Function(KeyboardEvent, String) keyDownAction,
  }) {
    final element = InputElement()
      ..classes.addAll(classes)
      ..value = value
      ..autofocus = isAutofocused;
    if (isAutofocused) {
      window.requestAnimationFrame((_) {
        element.focus();
      });
    }
    if (keyDownAction == null) return element;
    return element
      ..onKeyDown.listen((event) {
        _execute(keyDownAction(event, element.value));
      });
  }
}
