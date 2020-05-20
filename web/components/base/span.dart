import 'dart:html';

import 'package:clerk/clerk.dart';

class Span {
  factory Span() => _lastInstance;

  Span.create(this._executor) {
    _lastInstance = this;
  }

  static Span _lastInstance;

  final StoreExecutor _executor;

  Element render(
    String label, {
    Iterable<String> classes = const [],
    Action Function(MouseEvent) clickAction,
  }) {
    final element = SpanElement()
      ..classes.addAll(classes)
      ..appendText(label);
    if (clickAction == null) return element;
    return element
      ..onClick.listen((event) {
        _executor.execute(clickAction(event));
      });
  }
}
