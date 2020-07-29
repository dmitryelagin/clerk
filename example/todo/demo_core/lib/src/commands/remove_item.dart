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

  Run call(TodoItemId id) {
    return (store) async {
      if (store.read(_todoList.isPendingItem(id))) return;

      store.apply(_todoList.resetItemValidity(id));

      if (id.isFake) {
        store.apply(_todoList.removeItem(id));
        return;
      }

      try {
        store.apply(_todoList.setItemIsPending(id));
        await _loader.removeItem(id);
        store.apply(_todoList.removeItem(id));
      } on Exception catch (_) {
        store
          ..apply(_todoList.validateItem(id, const RemoveItemFailure()))
          ..apply(_todoList.setItemIsSynchronized(id));
      }
    };
  }
}
