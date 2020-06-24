import 'package:clerk/clerk.dart';

import '../models/todo_item_id.dart';
import '../models/todo_item_id_utils.dart';
import '../models/todo_validity.dart';
import '../services/todo_loader.dart';
import '../states/todo_list/todo_list_state.dart';

class RemoveItem {
  const RemoveItem(this._todoList, this._loader);

  final TodoListManager _todoList;
  final TodoLoader _loader;

  Action call(TodoItemId id) {
    return Action((store) async {
      if (id.isFake) {
        store.write(_todoList.removeItem(id));
        return;
      }

      try {
        store.write(_todoList.setItemIsPending(id));
        await _loader.removeItem(id);
        store.write(_todoList.removeItem(id));
      } on Exception catch (_) {
        store
          ..write(_todoList.validateItem(id, const RemoveItemFailure()))
          ..write(_todoList.setItemIsSynchronized(id));
      }
    });
  }
}
