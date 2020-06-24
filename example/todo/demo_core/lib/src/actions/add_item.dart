import 'package:clerk/clerk.dart';

import '../models/todo_item_id.dart';
import '../services/todo_loader.dart';
import '../states/todo_list/todo_list_state.dart';

class AddItem {
  const AddItem(this._todoList, this._loader);

  static const addFailMessage = 'Failed to add item. Please, try again.';

  final TodoListManager _todoList;
  final TodoLoader _loader;

  Action call(String label) {
    return Action((store) async {
      const fakeId = TodoItemId.fake;
      final isDone = store.read(_todoList.getItem(fakeId)).isDone;
      store
        ..write(_todoList.changeItemLabel(fakeId, label))
        ..write(_todoList.setItemIsPending(fakeId));

      try {
        final createdId = await _loader.addItem(label, isDone: isDone);
        store
          ..write(_todoList.removeItem(fakeId))
          ..write(_todoList.addItem(createdId, label: label, isDone: isDone));
      } on Exception catch (_) {
        store.write(_todoList.changeItemValidity(fakeId, addFailMessage));
      } finally {
        store.write(_todoList.setItemIsSynchronized(fakeId));
      }
    });
  }
}
