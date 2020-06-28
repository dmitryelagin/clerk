import 'package:clerk/clerk.dart';

import '../models/todo_item_id.dart';
import '../states/todo_list/todo_list_state.dart';

class StartItemAdd {
  const StartItemAdd(this._todoList);

  final TodoListManager _todoList;

  Execute call() {
    return (store) {
      store.write(_todoList.addItem(TodoItemId.fake, ''));
    };
  }
}