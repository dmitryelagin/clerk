import 'package:clerk/clerk.dart';

import '../models/todo_item_id.dart';
import '../models/todo_validity.dart';
import '../services/todo_loader.dart';
import '../states/todo_list/todo_list_state.dart';

class ChangeItem {
  const ChangeItem(this._todoList, this._loader);

  final TodoListManager _todoList;
  final TodoLoader _loader;

  Run call(TodoItemId id, [String label]) {
    return (store) async {
      if (store.read(_todoList.isPendingItem(id))) return;

      final previousItem = store.read(_todoList.getItem(id));
      store.apply(_todoList.resetItemValidity(id));

      if (label != null) {
        if (previousItem.label == label) return;
        store.apply(_todoList.changeItem(id, label));
      }

      final updatedLabel = label ?? previousItem.label;
      store.apply(_todoList.setItemIsPending(id));

      try {
        await _loader.changeItem(id, label: updatedLabel);
      } on Exception catch (_) {
        store.apply(_todoList.validateItem(id, const ChangeItemFailure()));
      } finally {
        store.apply(_todoList.setItemIsSynchronized(id));
      }
    };
  }
}
