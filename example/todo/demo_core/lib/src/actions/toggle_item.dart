import 'package:clerk/clerk.dart';

import '../models/todo_item_id.dart';
import '../services/todo_loader.dart';
import '../states/todo_list/todo_list_state.dart';

class ToggleItem {
  const ToggleItem(this._todoList, this._loader);

  final TodoListManager _todoList;
  final TodoLoader _loader;

  Action call(TodoItemId id, {bool isDone}) {
    return Action((store) async {
      store.assign(_todoList.toggleItem(id, isDone: isDone));

      try {
        await _loader.changeItem(id, isDone: isDone);
      } on Exception catch (e) {
        print(e);
      }
    });
  }
}
