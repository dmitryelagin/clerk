import 'package:clerk/clerk.dart';

import '../models/todo_item_id.dart';
import '../models/todo_item_id_utils.dart';
import '../services/todo_loader.dart';
import '../states/todo_list/todo_list_state.dart';

abstract class RemoveItem {
  Action removeItem(TodoItemId id);
}

mixin RemoveItemFactory implements RemoveItem {
  TodoListManager get todoList;
  TodoLoader get loader;

  @override
  Action removeItem(TodoItemId id) {
    return Action((store) async {
      store.assign(todoList.removeItem(id));

      if (id.isFake) return;

      try {
        await loader.removeItem(id);
      } on Exception catch (e) {
        print(e);
      }
    });
  }
}
