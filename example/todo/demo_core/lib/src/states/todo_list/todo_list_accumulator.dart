import '../../models/todo_item.dart';
import 'todo_list_model.dart';

class TodoListAccumulator {
  TodoListAccumulator();

  TodoListAccumulator.fromModel(TodoListModel model)
      : items = model.items.toList();

  List<TodoItem> items = [];
}
