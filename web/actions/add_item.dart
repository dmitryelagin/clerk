import 'package:clerk/clerk.dart';

import '../models/todo_item_id.dart';
import '../services/todo_loader.dart';
import '../states/todo_list/todo_list_state.dart';

mixin AddItem {
  TodoListManager get todoList;
  TodoLoader get loader;

  Action addItem(String label) => Action((store) async {
        if (store.evaluate(todoList.hasNoAddInteraction())) return;

        store
          ..assign(todoList.changeItem(TodoItemId.fake, label))
          ..assign(todoList.stopItemChange());

        try {
          final createdId = await loader.addItem(label);
          store
            ..assign(todoList.removeItem(TodoItemId.fake))
            ..assign(todoList.addItem(createdId, label));
        } on Exception catch (e) {
          print(e);
        }
      });
}
