import '../models/todo_item_id.dart';
import '../states/todo_list/todo_list.dart';

class StartItemAdd {
  const StartItemAdd();

  void call(TodoList todoList) {
    todoList.addItem(TodoItemId.fake, '');
  }
}
