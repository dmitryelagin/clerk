import 'package:clerk/clerk.dart';

import '../models/todo_item_id.dart';
import '../states/todo_list/todo_list_state.dart';

mixin ToggleItem {
  TodoListManager get todoList;

  Action toggleItem(TodoItemId id, {bool isDone}) => Action((store) {
        store.assign(todoList.toggleItem(id, isDone: isDone));
      });
}
