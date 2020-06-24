import 'todo_item_id.dart';
import 'todo_validity.dart';

class TodoItem {
  TodoItem(
    this.id,
    this.label, {
    this.isDone = false,
    this.isPending = false,
    this.validity = const TodoValidity(),
  });

  final TodoItemId id;
  final String label;
  final bool isDone;
  final bool isPending;
  final TodoValidity validity;

  bool get isValid => validity == const TodoValidity();
}
