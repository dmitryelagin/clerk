import 'package:clerk/clerk.dart';

import '../../models/todo_item.dart';
import '../../models/todo_item_id.dart';
import '../../models/todo_item_id_utils.dart';
import 'todo_list_model.dart';

class TodoListReader<M extends TodoListModel> {
  Read<M, Iterable<TodoItemId>> getItemsIds() =>
      (model) => model.items.map((item) => item.id);

  Read<M, TodoItem> getItem(TodoItemId id) =>
      (model) => model.items.firstWhere((item) => item.id.value == id.value);

  Read<M, bool> isPendingItem(TodoItemId id) =>
      (model) => getItem(id)(model).isPending;

  Read<M, bool> isAddingAvailable() =>
      (model) => getItemsIds()(model).every((id) => !id.isFake);
}
