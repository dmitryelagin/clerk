import 'package:clerk/clerk.dart';

import '../models/todo_item_id.dart';
import '../states/todo_list/todo_list_state.dart';

mixin CancelItemChange {
  TodoListManager get todoList;

  Action cancelItemChange() => Action((store) {
        if (store.evaluate(todoList.hasAddInteraction())) {
          store.assign(todoList.removeItem(TodoItemId.fake));
        }
        store.assign(todoList.stopItemChange());
      });
}
