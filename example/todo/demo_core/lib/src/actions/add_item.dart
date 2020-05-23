import 'package:clerk/clerk.dart';

import '../models/todo_item_id.dart';
import '../services/todo_loader.dart';
import '../states/todo_list/todo_list_state.dart';

abstract class AddItem {
  Action addItem(String label);
}

mixin AddItemFactory implements AddItem {
  TodoListManager get todoList;
  TodoLoader get loader;

  @override
  Action addItem(String label) {
    return Action((store) async {
      final isDone = store.evaluate(todoList.getItem(TodoItemId.fake)).isDone;
      store.assign(todoList.changeItem(TodoItemId.fake, label));

      try {
        final createdId = await loader.addItem(label, isDone: isDone);
        store
          ..assign(todoList.removeItem(TodoItemId.fake))
          ..assign(todoList.addItem(createdId, label: label, isDone: isDone));
      } on Exception catch (e) {
        print(e);
      }
    });
  }
}
