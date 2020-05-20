import 'package:clerk/clerk.dart';

import '../models/todo_item_id.dart';
import '../states/todo_list/todo_list_state.dart';

mixin StartItemAdd {
  TodoListManager get todoList;

  Action startItemAdd() => Action((store) {
        const id = TodoItemId.fake();
        store
          ..assign(todoList.addItem(id))
          ..assign(todoList.startItemChange(id));
      });
}
