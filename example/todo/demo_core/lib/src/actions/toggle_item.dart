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

  Action call(TodoItemId id, {bool isDone = false}) {
    return Action((store) async {
      final previousItem = store.read(_todoList.getItem(id));
      store.write(_todoList.toggleItem(id, isDone: isDone));

      if (id.isFake || previousItem.isDone == isDone) return;

      store.write(_todoList.setItemIsPending(id));

      try {
        await _loader.changeItem(id, isDone: isDone);
      } on Exception catch (_) {
        store
          ..write(_todoList.toggleItem(id, isDone: previousItem.isDone))
          ..write(_todoList.changeItemValidity(id, const ToggleItemFailure()));
      } finally {
        store.write(_todoList.setItemIsSynchronized(id));
      }
    });
  }
}
