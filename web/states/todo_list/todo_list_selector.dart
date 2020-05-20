import '../../models/todo_item.dart';
import '../../models/todo_item_id.dart';
import 'todo_list_model.dart';

class TodoListSelector<M extends TodoListModel> {
  const TodoListSelector();

  static const standard = TodoListSelector();

  TodoItem getItem(M model, TodoItemId id) =>
      model.items.firstWhere((item) => item.id.value == id.value);

  Iterable<TodoItemId> getItemsIds(M model) =>
      model.items.map((item) => item.id);

  bool hasInteraction(M model) => model.editingItemId != null;

  bool hasAdding(M model) => model.editingItemId == const TodoItemId.fake();

  bool isChangingItem(M model, TodoItemId id) => model.editingItemId == id;

  bool isAddingAvailable(M model) =>
      getItemsIds(model).every((id) => id != const TodoItemId.fake());
}
