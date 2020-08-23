import '../../models/todo_item.dart';
import '../../models/todo_item_id.dart';
import '../../models/todo_item_id_utils.dart';
import '../../models/validity.dart';
import 'todo_list_model.dart';

class TodoListReader<M extends TodoListModel> {
  Iterable<TodoItemId> getItemsIds(M model) =>
      model.items.map((item) => item.id);

  bool hasItem(M model, TodoItemId id) =>
      model.items.any((item) => item.id.value == id.value);

  TodoItem getItem(M model, TodoItemId id) =>
      model.items.firstWhere((item) => item.id.value == id.value);

  Validity getValidity(M model) => model.validity;

  bool isPending(M model) => model.isPending;

  bool isPendingItem(M model, TodoItemId id) => getItem(model, id).isPending;

  bool isFakeItem(M model, TodoItemId id) => getItem(model, id).id.isFake;

  bool isAddingAvailable(M model) =>
      !model.isPending &&
      model.validity.isValid &&
      getItemsIds(model).every((id) => !id.isFake);
}
