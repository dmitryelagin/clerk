import 'todo_item_id.dart';
import 'validity.dart';

class TodoItem {
  TodoItem(
    this.id,
    this.label, {
    this.isDone = false,
    this.isPending = false,
    this.validity = Validity.valid,
  });

  final TodoItemId id;
  final String label;
  final bool isDone;
  final bool isPending;
  final Validity validity;
}
