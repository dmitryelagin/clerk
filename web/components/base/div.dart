import 'dart:html';

class Div {
  factory Div() => _lastInstance;

  Div.create() {
    _lastInstance = this;
  }

  static Div _lastInstance;

  Element render({
    Iterable<String> classes = const [],
    Iterable<Element> children = const [],
  }) {
    final element = DivElement()..classes.addAll(classes);
    children.forEach(element.append);
    return element;
  }
}
