import 'package:clerk/clerk.dart';

import '../models/todo_item_id.dart';
import '../states/todo_list/todo_list_state.dart';

mixin ChangeItem {
  TodoListManager get todoList;

  Action changeItem(TodoItemId id, String label) => Action((store) {
        store
          ..assign(todoList.stopItemChange())
          ..assign(todoList.changeItem(id, label));
      });
}
