import 'package:clerk/clerk.dart';

import '../models/todo_item_id.dart';
import '../models/todo_item_id_utils.dart';
import '../models/todo_validity.dart';
import '../services/todo_loader.dart';
import '../states/todo_list/todo_list_state.dart';

class ToggleItem {
  const ToggleItem(this._todoList, this._loader);

  final TodoListManager _todoList;
  final TodoLoader _loader;

  Run call(TodoItemId id, {bool isDone = false}) {
    return (store) async {
      if (store.read(_todoList.isPendingItem(id))) return;

      final previousItem = store.read(_todoList.getItem(id));
      store
        ..apply(_todoList.resetItemValidity(id))
        ..apply(_todoList.toggleItem(id, isDone: isDone));

      if (id.isFake || previousItem.isDone == isDone) return;

      store.apply(_todoList.setItemIsPending(id));

      try {
        await _loader.changeItem(id, isDone: isDone);
      } on Exception catch (_) {
        store
          ..apply(_todoList.toggleItem(id, isDone: previousItem.isDone))
          ..apply(_todoList.validateItem(id, const ToggleItemFailure()));
      } finally {
        store.apply(_todoList.setItemIsSynchronized(id));
      }
    };
  }
}
