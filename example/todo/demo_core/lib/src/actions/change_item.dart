import 'package:clerk/clerk.dart';

import '../models/todo_item_id.dart';
import '../services/todo_loader.dart';
import '../states/todo_list/todo_list_state.dart';

class ChangeItem {
  const ChangeItem(this._todoList, this._loader);

  final TodoListManager _todoList;
  final TodoLoader _loader;

  Action call(TodoItemId id, String label) {
    return Action((store) async {
      final previousItem = store.evaluate(_todoList.getItem(id));
      store.assign(_todoList.changeItem(id, label));

      if (previousItem.label == label) return;

      try {
        await _loader.changeItem(id, label: label);
      } on Exception catch (e) {
        print(e);
      }
    });
  }
}
