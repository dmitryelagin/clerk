import '../../models/todo_item.dart';
import 'todo_list.dart';

class TodoListModel {
  TodoListModel.fromAccumulator(TodoList accumulator)
      : items = accumulator.getItems();

  final Iterable<TodoItem> items;
}
