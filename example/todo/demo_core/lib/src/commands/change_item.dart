import '../models/todo_item_id.dart';
import '../models/todo_validity.dart';
import '../services/todo_loader.dart';
import '../states/todo_list/todo_list.dart';

class ChangeItem {
  const ChangeItem(this._loader);

  final TodoLoader _loader;

  Future<void> call(TodoList todoList, TodoItemId id, [String? label]) async {
    if (todoList.isPendingItem(id)) return;

    final previousItem = todoList.getItem(id);
    todoList.resetItemValidity(id);

    if (label != null) {
      if (previousItem.label == label) return;
      todoList.changeItem(id, label);
    }

    final updatedLabel = label ?? previousItem.label;
    todoList.setItemIsPending(id);

    try {
      await _loader.changeItem(id, label: updatedLabel);
    } on Exception catch (_) {
      todoList.validateItem(id, const ChangeItemFailure());
    } finally {
      todoList.setItemIsSynchronized(id);
    }
  }
}
