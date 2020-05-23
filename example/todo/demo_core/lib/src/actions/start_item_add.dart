import 'package:clerk/clerk.dart';

import '../models/todo_item_id.dart';
import '../states/todo_list/todo_list_state.dart';

abstract class StartItemAdd {
  Action startItemAdd();
}

mixin StartItemAddFactory implements StartItemAdd {
  TodoListManager get todoList;

  @override
  Action startItemAdd() {
    return Action((store) {
      store.assign(todoList.addItem(TodoItemId.fake));
    });
  }
}
