import 'package:clerk/clerk.dart';

import '../models/todo_item_id.dart';
import '../models/todo_validity.dart';
import '../services/todo_loader.dart';
import '../states/todo_list/todo_list_state.dart';

class AddItem {
  const AddItem(this._todoList, this._loader);

  final TodoListManager _todoList;
  final TodoLoader _loader;

  Run call([String label]) {
    return (store) async {
      const fakeId = TodoItemId.fake;
      if (store.read(_todoList.isPendingItem(fakeId))) return;

      final previousItem = store.read(_todoList.getItem(fakeId));
      final updatedLabel = label ?? previousItem.label;
      final isDone = previousItem.isDone;
      store
        ..apply(_todoList.resetItemValidity(fakeId))
        ..apply(_todoList.changeItem(fakeId, updatedLabel))
        ..apply(_todoList.setItemIsPending(fakeId));

      try {
        final createdId = await _loader.addItem(updatedLabel, isDone: isDone);
        store
          ..apply(_todoList.removeItem(fakeId))
          ..apply(_todoList.addItem(createdId, updatedLabel, isDone: isDone));
      } on Exception catch (_) {
        store
          ..apply(_todoList.validateItem(fakeId, const AddItemFailure()))
          ..apply(_todoList.setItemIsSynchronized(fakeId));
      }
    };
  }
}
