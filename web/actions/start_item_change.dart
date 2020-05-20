import 'package:clerk/clerk.dart';

import '../models/todo_item_id.dart';
import '../states/todo_list/todo_list_state.dart';

mixin StartItemChange {
  TodoListManager get todoList;

  Action startItemChange(TodoItemId id) => Action((store) {
        store.assignUnary(todoList.startItemChange, id);
      });
}
