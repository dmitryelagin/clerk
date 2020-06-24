import 'todo_item.dart';

extension TodoItemUtils on TodoItem {
  TodoItem update({String label, String validity = '', bool isDone}) {
    return TodoItem(
      id,
      label ?? this.label,
      validity ?? this.validity,
      isDone: isDone ?? this.isDone,
    );
  }

  bool equals(TodoItem other) =>
      id == other.id &&
      label == other.label &&
      validity == other.validity &&
      isDone == other.isDone;
}
