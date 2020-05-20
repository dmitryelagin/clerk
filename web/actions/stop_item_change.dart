import 'package:clerk/clerk.dart';

import '../models/todo_item_id.dart';
import '../states/todo_list/todo_list_state.dart';

mixin StopItemChange {
  TodoListManager get todoList;

  Action stopItemChange() => Action((store) {
        if (store.evaluate(todoList.hasAdding())) {
          store.assign(todoList.removeItem(const TodoItemId.fake()));
        }
        store.assign(todoList.stopItemChange());
      });
}
