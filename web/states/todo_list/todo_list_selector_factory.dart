import 'package:clerk/clerk.dart';

import '../../models/todo_item.dart';
import '../../models/todo_item_id.dart';
import 'todo_list_model.dart';

class TodoListSelectorFactory<M extends TodoListModel> {
  Selector<M, TodoItem> getItem(TodoItemId id) =>
      (model) => model.items.firstWhere((item) => item.id.value == id.value);

  Selector<M, Iterable<TodoItemId>> getItemsIds() =>
      (model) => model.items.map((item) => item.id);

  Selector<M, bool> hasInteraction() => (model) => model.editingItemId != null;

  Selector<M, bool> hasAdding() =>
      (model) => TodoItemId.isFake(model.editingItemId);

  Selector<M, bool> isChangingItem(TodoItemId id) =>
      (model) => model.editingItemId == id;

  Selector<M, bool> isNotChangingItem(TodoItemId id) =>
      (model) => model.editingItemId != id;

  Selector<M, bool> isAddingAvailable() =>
      (model) => getItemsIds()(model).every((id) => !TodoItemId.isFake(id));
}
