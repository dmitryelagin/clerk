import 'package:clerk/clerk.dart';

import '../models/todo_item_id.dart';
import '../services/todo_loader.dart';
import '../states/todo_list/todo_list_state.dart';

class AddItem {
  const AddItem(this._todoList, this._loader);

  final TodoListManager _todoList;
  final TodoLoader _loader;

  Action call(String label) {
    return Action((store) async {
      final isDone = store.evaluate(_todoList.getItem(TodoItemId.fake)).isDone;
      store.assign(_todoList.changeItem(TodoItemId.fake, label));

      try {
        final createdId = await _loader.addItem(label, isDone: isDone);
        store
          ..assign(_todoList.removeItem(TodoItemId.fake))
          ..assign(_todoList.addItem(createdId, label: label, isDone: isDone));
      } on Exception catch (e) {
        print(e);
      }
    });
  }
}
