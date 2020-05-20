import '../../models/todo_item.dart';
import '../../models/todo_item_id.dart';
import 'todo_list_accumulator.dart';

class TodoListModel {
  TodoListModel.fromAccumulator(TodoListAccumulator accumulator)
      : items = List.unmodifiable(accumulator.items),
        editingItemId = accumulator.editingItemId;

  final Iterable<TodoItem> items;
  final TodoItemId editingItemId;
}
