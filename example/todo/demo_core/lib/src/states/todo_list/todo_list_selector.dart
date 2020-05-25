import 'package:clerk/clerk.dart';

import '../../models/todo_item.dart';
import '../../models/todo_item_id.dart';
import '../../models/todo_item_id_utils.dart';
import 'todo_list_model.dart';

class TodoListSelector<M extends TodoListModel> {
  Selector<M, TodoItem> getItem(TodoItemId id) =>
      (model) => model.items.firstWhere((item) => item.id.value == id.value);

  Selector<M, Iterable<TodoItemId>> getItemsIds() =>
      (model) => model.items.map((item) => item.id);

  Selector<M, bool> isItemDone(TodoItemId id) =>
      (model) => getItem(id)(model).isDone;

  Selector<M, bool> isAddingAvailable() =>
      (model) => getItemsIds()(model).every((id) => !id.isFake);
}
