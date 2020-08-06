import '../models/todo_item_id.dart';
import '../models/todo_item_id_utils.dart';
import '../models/todo_validity.dart';
import '../services/todo_loader.dart';
import '../states/todo_list/todo_list.dart';

class ToggleItem {
  const ToggleItem(this._loader);

  final TodoLoader _loader;

  Future<void> call(
    TodoList todoList,
    TodoItemId id, [
    bool isDone = false, // ignore: avoid_positional_boolean_parameters
  ]) async {
    if (todoList.isPendingItem(id)) return;

    final previousItem = todoList.getItem(id);
    todoList
      ..resetItemValidity(id)
      ..toggleItem(id, isDone: isDone);

    if (id.isFake || previousItem.isDone == isDone) return;

    todoList.setItemIsPending(id);

    try {
      await _loader.changeItem(id, isDone: isDone);
    } on Exception catch (_) {
      todoList
        ..toggleItem(id, isDone: previousItem.isDone)
        ..validateItem(id, const ToggleItemFailure());
    } finally {
      todoList.setItemIsSynchronized(id);
    }
  }
}
