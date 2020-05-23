import 'todo_item_id.dart';

class TodoItem {
  const TodoItem(this.id, this.label, {this.isDone = false});

  final TodoItemId id;
  final String label;
  final bool isDone;
}
