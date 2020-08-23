import '../../models/todo_item.dart';
import '../../models/validity.dart';
import 'todo_list.dart';

class TodoListModel {
  TodoListModel.fromAccumulator(TodoList accumulator)
      : items = accumulator.getItems(),
        validity = accumulator.validity,
        isPending = accumulator.isPending;

  final Iterable<TodoItem> items;
  final Validity validity;
  final bool isPending;
}
