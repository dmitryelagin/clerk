import 'todo_item.dart';

extension TodoItemUtils on TodoItem {
  TodoItem update({String? label, bool? isDone}) =>
      TodoItem(id, label ?? this.label, isDone: isDone ?? this.isDone);

  bool equals(TodoItem other) =>
      id == other.id && label == other.label && isDone == other.isDone;
}
