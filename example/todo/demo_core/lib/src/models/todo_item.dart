import 'todo_item_id.dart';

class TodoItem {
  const TodoItem(this.id, this.label, this.validity, {this.isDone = false});

  final TodoItemId id;
  final String label;
  final String validity;
  final bool isDone;

  bool get isValid => validity.isEmpty;
}
