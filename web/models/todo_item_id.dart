class TodoItemId {
  const TodoItemId(this.value);

  const TodoItemId.fake() : value = null;

  static bool isFake(TodoItemId id) => id == const TodoItemId.fake();

  final int value;
}
