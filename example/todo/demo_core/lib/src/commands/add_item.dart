import 'package:clerk/clerk.dart';

import '../models/todo_item_id.dart';
import '../models/todo_validity.dart';
import '../services/todo_loader.dart';
import '../states/todo_list/todo_list_state.dart';

class AddItem {
  const AddItem(this._todoList, this._loader);

  final TodoListManager _todoList;
  final TodoLoader _loader;

  Execute call([String label]) {
    return (store) async {
      const fakeId = TodoItemId.fake;
      if (store.read(_todoList.isPendingItem(fakeId))) return;

      final previousItem = store.read(_todoList.getItem(fakeId));
      final updatedLabel = label ?? previousItem.label;
      final isDone = previousItem.isDone;
      store
        ..write(_todoList.resetItemValidity(fakeId))
        ..write(_todoList.changeItem(fakeId, updatedLabel))
        ..write(_todoList.setItemIsPending(fakeId));

      try {
        final createdId = await _loader.addItem(updatedLabel, isDone: isDone);
        store
          ..write(_todoList.removeItem(fakeId))
          ..write(_todoList.addItem(createdId, updatedLabel, isDone: isDone));
      } on Exception catch (_) {
        store
          ..write(_todoList.validateItem(fakeId, const AddItemFailure()))
          ..write(_todoList.setItemIsSynchronized(fakeId));
      }
    };
  }
}