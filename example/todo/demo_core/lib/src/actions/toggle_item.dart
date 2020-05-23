import 'package:clerk/clerk.dart';

import '../models/todo_item_id.dart';
import '../services/todo_loader.dart';
import '../states/todo_list/todo_list_state.dart';

abstract class ToggleItem {
  Action toggleItem(TodoItemId id, {bool isDone});
}

mixin ToggleItemFactory implements ToggleItem {
  TodoListManager get todoList;
  TodoLoader get loader;

  @override
  Action toggleItem(TodoItemId id, {bool isDone}) {
    return Action((store) async {
      store.assign(todoList.toggleItem(id, isDone: isDone));

      try {
        await loader.changeItem(id, isDone: isDone);
      } on Exception catch (e) {
        print(e);
      }
    });
  }
}
