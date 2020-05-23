import '../../models/todo_item.dart';
import 'todo_list_accumulator.dart';

class TodoListModel {
  TodoListModel.fromAccumulator(TodoListAccumulator accumulator)
      : items = List.unmodifiable(accumulator.items);

  final Iterable<TodoItem> items;
}
