import 'package:clerk/clerk.dart';

import '../models/todo_item_id.dart';
import '../services/todo_loader.dart';
import '../states/todo_list/todo_list_state.dart';

abstract class ChangeItem {
  Action changeItem(TodoItemId id, String label);
}

mixin ChangeItemFactory implements ChangeItem {
  TodoListManager get todoList;
  TodoLoader get loader;

  @override
  Action changeItem(TodoItemId id, String label) {
    return Action((store) async {
      final item = store.evaluate(todoList.getItem(id));
      store.assign(todoList.changeItem(id, label));

      if (item.label == label) return;

      try {
        await loader.changeItem(id, label: label);
      } on Exception catch (e) {
        print(e);
      }
    });
  }
}
