import '../models/todo_item_id.dart';
import '../models/todo_item_id_utils.dart';
import '../models/todo_validity.dart';
import '../services/todo_loader.dart';
import '../states/todo_list/todo_list.dart';

class RemoveItem {
  const RemoveItem(this._loader);

  final TodoLoader _loader;

  Future<void> call(TodoList todoList, TodoItemId id) async {
    if (todoList.isPendingItem(id)) return;

    todoList.revertItemValidity(id);

    if (id.isFake) {
      todoList.removeItem(id);
      return;
    }

    try {
      todoList.setItemIsPending(id);
      await _loader.removeItem(id);
      todoList.removeItem(id);
    } on Exception catch (_) {
      todoList
        ..validateItem(id, const RemoveItemFailure())
        ..setItemIsSynchronized(id);
    }
  }
}
