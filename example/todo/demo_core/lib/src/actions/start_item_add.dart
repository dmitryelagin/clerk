import 'package:clerk/clerk.dart';

import '../models/todo_item_id.dart';
import '../states/todo_list/todo_list_state.dart';
import '../utils/action_utils.dart';

class StartItemAdd {
  const StartItemAdd(this._todoList);

  final TodoListManager _todoList;

  Action call() => Action(executeWrite(_todoList.addItem(TodoItemId.fake)));
}
