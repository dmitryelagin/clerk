import 'package:clerk/clerk.dart';

import '../../models/todo_item.dart';
import '../../models/todo_item_id.dart';
import '../../models/todo_item_id_utils.dart';
import 'todo_list_model.dart';

class TodoListReader<M extends TodoListModel> {
  Read<M, TodoItem> getItem(TodoItemId id) =>
      (model) => model.items.firstWhere((item) => item.id.value == id.value);

  Read<M, Iterable<TodoItem>> getItems() => (model) => List.of(model.items);

  Read<M, bool> isAddingAvailable() =>
      (model) => getItems()(model).every((item) => !item.id.isFake);
}
