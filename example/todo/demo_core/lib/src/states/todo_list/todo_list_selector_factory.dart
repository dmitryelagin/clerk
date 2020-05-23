import 'package:clerk/clerk.dart';

import '../../models/todo_item.dart';
import '../../models/todo_item_id.dart';
import '../../models/todo_item_id_utils.dart';
import 'todo_list_model.dart';

class TodoListSelectorFactory<M extends TodoListModel> {
  Selector<M, TodoItem> getItem(TodoItemId id) =>
      (model) => model.items.firstWhere((item) => item.id.value == id.value);

  Selector<M, Iterable<TodoItemId>> getItemsIds() =>
      (model) => model.items.map((item) => item.id);

  Selector<M, bool> hasInteraction() => (model) => model.editingItemId != null;

  Selector<M, bool> hasAddInteraction() =>
      (model) => model.editingItemId.isFake;

  Selector<M, bool> hasNoAddInteraction() =>
      (model) => !hasAddInteraction()(model);

  Selector<M, bool> isAddingItem(TodoItemId id) =>
      (model) => hasAddInteraction()(model) && isChangingItem(id)(model);

  Selector<M, bool> isChangingItem(TodoItemId id) =>
      (model) => model.editingItemId == id;

  Selector<M, bool> isAddingAvailable() =>
      (model) => getItemsIds()(model).every((id) => !id.isFake);
}
