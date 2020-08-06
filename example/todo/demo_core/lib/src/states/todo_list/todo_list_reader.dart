import '../../models/todo_item.dart';
import '../../models/todo_item_id.dart';
import '../../models/todo_item_id_utils.dart';
import 'todo_list_model.dart';

class TodoListReader<M extends TodoListModel> {
  Iterable<TodoItemId> getItemsIds(M model) =>
      model.items.map((item) => item.id);

  TodoItem getItem(M model, TodoItemId id) =>
      model.items.firstWhere((item) => item.id.value == id.value);

  bool isPendingItem(M model, TodoItemId id) => getItem(model, id).isPending;

  bool isAddingAvailable(M model) =>
      getItemsIds(model).every((id) => !id.isFake);
}
