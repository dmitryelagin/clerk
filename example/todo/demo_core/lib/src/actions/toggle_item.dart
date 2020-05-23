import 'package:clerk/clerk.dart';

import '../models/todo_item_id.dart';
import '../states/todo_list/todo_list_state.dart';

abstract class ToggleItem {
  Action toggleItem(TodoItemId id, {bool isDone});
}

mixin ToggleItemFactory implements ToggleItem {
  TodoListManager get todoList;

  @override
  Action toggleItem(TodoItemId id, {bool isDone}) => Action((store) {
        store.assign(todoList.toggleItem(id, isDone: isDone));
      });
}
