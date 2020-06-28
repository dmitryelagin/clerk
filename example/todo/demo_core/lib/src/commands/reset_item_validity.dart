import 'package:clerk/clerk.dart';

import '../models/todo_item_id.dart';
import '../states/todo_list/todo_list_state.dart';

class ResetItemValidity {
  const ResetItemValidity(this._todoList);

  final TodoListManager _todoList;

  Execute call(TodoItemId id) {
    return (store) {
      store.write(_todoList.resetItemValidity(id));
    };
  }
}
