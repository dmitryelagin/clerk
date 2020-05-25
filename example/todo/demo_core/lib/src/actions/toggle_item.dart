import 'package:clerk/clerk.dart';

import '../models/todo_item_id.dart';
import '../models/todo_item_id_utils.dart';
import '../services/todo_loader.dart';
import '../states/todo_list/todo_list_state.dart';

class ToggleItem {
  const ToggleItem(this._todoList, this._loader);

  final TodoListManager _todoList;
  final TodoLoader _loader;

  Action call(TodoItemId id, {bool isDone}) {
    return Action((store) async {
      final previousItem = store.evaluate(_todoList.getItem(id));
      store.assign(_todoList.toggleItem(id, isDone: isDone));

      if (id.isFake || previousItem.isDone == isDone) return;

      try {
        await _loader.changeItem(id, isDone: isDone);
      } on Exception catch (e) {
        print(e);
      }
    });
  }
}
