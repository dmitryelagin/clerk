import 'package:clerk/clerk.dart';

import '../models/todo_item_id.dart';
import '../states/todo_list/todo_list_state.dart';
import '../utils/action_utils.dart';

class ResetItemValidity {
  const ResetItemValidity(this._todoList);

  final TodoListManager _todoList;

  Action call(TodoItemId id) =>
      Action(executeWrite(_todoList.validateItem(id)));
}
