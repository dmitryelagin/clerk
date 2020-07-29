import 'package:clerk/clerk.dart';

import '../models/todo_item_id.dart';
import '../states/todo_list/todo_list_state.dart';

class ResetItemValidity {
  const ResetItemValidity(this._todoList);

  final TodoListManager _todoList;

  Run call(TodoItemId id) {
    return (store) {
      store.apply(_todoList.resetItemValidity(id));
    };
  }
}
