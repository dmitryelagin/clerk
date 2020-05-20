import '../../models/todo_item.dart';
import '../../models/todo_item_id.dart';
import 'todo_list_accumulator.dart';

class TodoListModel {
  TodoListModel.fromAccumulator(TodoListAccumulator accumulator)
      : items = List.unmodifiable(accumulator.items),
        editingItemId = accumulator.editingItemId;

  static bool areEqual(TodoListModel a, TodoListModel b) {
    if (a.editingItemId != b.editingItemId) return false;
    if (a.items.length != b.items.length) return false;
    for (var i = 0; i < a.items.length; i += 1) {
      final first = a.items.elementAt(i);
      final second = b.items.elementAt(i);
      if (!TodoItem.areEqual(first, second)) return false;
    }
    return true;
  }

  final Iterable<TodoItem> items;
  final TodoItemId editingItemId;
}
