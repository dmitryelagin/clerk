import 'todo_item_id.dart';

class TodoItem {
  const TodoItem(this.id, this.label, {this.isChecked = false});

  static bool areEqual(TodoItem a, TodoItem b) =>
      a.id == b.id && a.label == b.label && a.isChecked == b.isChecked;

  final TodoItemId id;
  final String label;
  final bool isChecked;
}
