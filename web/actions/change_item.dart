import 'package:clerk/clerk.dart';

import '../models/todo_item_id.dart';
import '../services/todo_loader.dart';
import '../states/todo_list/todo_list_state.dart';

mixin ChangeItem {
  TodoListManager get todoList;
  TodoLoader get loader;

  Action changeItem(TodoItemId id, String label) => Action((store) async {
        final item = store.evaluate(todoList.getItem(id));
        store
          ..assign(todoList.changeItem(id, label))
          ..assign(todoList.stopItemChange());

        if (item.label == label) return;

        try {
          await loader.changeItem(id, label);
        } on Exception catch (e) {
          print(e);
        }
      });
}
