import '../models/todo_item_id.dart';
import '../states/todo_list/todo_list.dart';

class ResetItemValidity {
  const ResetItemValidity();

  void call(TodoList todoList, TodoItemId id) {
    todoList.resetItemValidity(id);
  }
}
