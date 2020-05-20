import 'package:clerk/clerk.dart';

import '../models/todo_item_id.dart';
import '../states/todo_list/todo_list_state.dart';

mixin AddItem {
  TodoListManager get todoList;

  Action addItem(TodoItemId id, String label) => Action((store) {
        store.assign(todoList.addItem(id, label));
      });
}
