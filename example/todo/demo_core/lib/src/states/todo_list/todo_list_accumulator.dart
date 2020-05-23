import '../../models/todo_item.dart';
import '../../models/todo_item_id.dart';
import 'todo_list_model.dart';

class TodoListAccumulator {
  TodoListAccumulator();

  TodoListAccumulator.fromModel(TodoListModel model)
      : items = model.items.toList(),
        editingItemId = model.editingItemId;

  List<TodoItem> items = [];
  TodoItemId editingItemId;
}
