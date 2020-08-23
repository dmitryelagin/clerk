import '../models/todo_validity.dart';
import '../services/todo_loader.dart';
import '../states/todo_list/todo_list.dart';

class FetchItems {
  const FetchItems(this._loader);

  final TodoLoader _loader;

  Future<void> call(TodoList todoList) async {
    todoList.isPending = true;

    try {
      final data = await _loader.fetchItems();
      todoList
        ..resetValidity()
        ..replaceItems(data.items);
    } on Exception catch (_) {
      todoList
        ..clear()
        ..validity = const ListLoadingFailure();
    } finally {
      todoList.isPending = false;
    }
  }
}
