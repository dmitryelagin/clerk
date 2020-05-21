import 'package:clerk/clerk.dart';

import '../models/todo_item_id.dart';
import '../services/todo_loader.dart';
import '../states/todo_list/todo_list_state.dart';

mixin AddItem {
  TodoListManager get todoList;
  TodoLoader get loader;

  Action addItem(String label) => Action((store) async {
        if (!store.evaluate(todoList.hasAdding())) return;

        const fakeId = TodoItemId.fake();
        store
          ..assign(todoList.changeItem(fakeId, label))
          ..assign(todoList.stopItemChange());

        try {
          final createdId = await loader.addItem(label);
          store
            ..assign(todoList.removeItem(fakeId))
            ..assign(todoList.addItem(createdId, label));
        } on Exception catch (e) {
          print(e);
        }
      });
}
