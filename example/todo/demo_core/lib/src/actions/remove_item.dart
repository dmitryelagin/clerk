import 'package:clerk/clerk.dart';

import '../models/todo_item_id.dart';
import '../models/todo_item_id_utils.dart';
import '../services/todo_loader.dart';
import '../states/todo_list/todo_list_state.dart';

class RemoveItem {
  const RemoveItem(this._todoList, this._loader);

  final TodoListManager _todoList;
  final TodoLoader _loader;

  Action call(TodoItemId id) {
    return Action((store) async {
      store.assign(_todoList.removeItem(id));

      if (id.isFake) return;

      try {
        await _loader.removeItem(id);
      } on Exception catch (e) {
        print(e);
      }
    });
  }
}
