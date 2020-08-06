import '../models/todo_item_id.dart';
import '../models/todo_validity.dart';
import '../services/todo_loader.dart';
import '../states/todo_list/todo_list.dart';

class AddItem {
  const AddItem(this._loader);

  final TodoLoader _loader;

  Future<void> call(TodoList todoList, [String label]) async {
    const fakeId = TodoItemId.fake;
    if (todoList.isPendingItem(fakeId)) return;

    final previousItem = todoList.getItem(fakeId);
    final updatedLabel = label ?? previousItem.label;
    final isDone = previousItem.isDone;
    todoList
      ..resetItemValidity(fakeId)
      ..changeItem(fakeId, updatedLabel)
      ..setItemIsPending(fakeId);

    try {
      final createdId = await _loader.addItem(updatedLabel, isDone: isDone);
      todoList
        ..removeItem(fakeId)
        ..addItem(createdId, updatedLabel, isDone: isDone);
    } on Exception catch (_) {
      todoList
        ..validateItem(fakeId, const AddItemFailure())
        ..setItemIsSynchronized(fakeId);
    }
  }
}
