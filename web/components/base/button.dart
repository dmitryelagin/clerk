import 'dart:html';

import 'package:clerk/clerk.dart';

class Button {
  factory Button() => _lastInstance;

  Button.create(this._execute) {
    _lastInstance = this;
  }

  static Button _lastInstance;

  final Execute _execute;

  Element render(
    String label, {
    Iterable<String> classes = const [],
    Action Function(MouseEvent) clickAction,
  }) {
    final element = ButtonElement()
      ..classes.addAll(classes)
      ..appendText(label);
    if (clickAction == null) return element;
    return element
      ..onClick.listen((event) {
        _execute(clickAction(event));
      });
  }
}
