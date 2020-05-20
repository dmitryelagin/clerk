import 'package:clerk/clerk.dart';

import '../models/todo_item_id.dart';
import '../states/todo_list/todo_list_state.dart';

mixin RemoveItem {
  TodoListManager get todoList;

  Action removeItem(TodoItemId id) => Action((store) {
        store.assign(todoList.removeItem(id));
      });
}
