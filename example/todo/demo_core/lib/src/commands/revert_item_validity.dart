import '../models/todo_item_id.dart';
import '../states/todo_list/todo_list.dart';

class RevertItemValidity {
  const RevertItemValidity();

  void call(TodoList todoList, TodoItemId id) {
    todoList.revertItemValidity(id);
  }
}
