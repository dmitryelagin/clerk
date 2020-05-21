import 'package:clerk/clerk.dart';

import '../models/todo_item_id.dart';
import '../services/todo_loader.dart';
import '../states/todo_list/todo_list_state.dart';

mixin RemoveItem {
  TodoListManager get todoList;
  TodoLoader get loader;

  Action removeItem(TodoItemId id) => Action((store) async {
        store.assign(todoList.removeItem(id));

        if (TodoItemId.isFake(id)) return;

        try {
          await loader.removeItem(id);
        } on Exception catch (e) {
          print(e);
        }
      });
}
