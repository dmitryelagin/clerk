class TodoItemId {
  const TodoItemId(this.value);

  static const fake = TodoItemId(null);

  final int value;

  @override
  String toString() => value?.toString() ?? '';
}
