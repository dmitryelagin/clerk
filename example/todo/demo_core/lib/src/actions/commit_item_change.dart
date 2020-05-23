import 'package:clerk/clerk.dart';

import '../../demo_core.dart';
import '../models/todo_item_id.dart';
import '../models/todo_item_id_utils.dart';
import 'add_item.dart';
import 'change_item.dart';
import 'remove_item.dart';

abstract class CommitItemChange {
  Action commitItemChange(TodoItemId id, String label);
}

mixin CommitItemChangeFactory
    on AddItem, ChangeItem, RemoveItem
    implements CommitItemChange {
  TodoListManager get todoList;

  @override
  Action commitItemChange(TodoItemId id, String label) {
    return Action((store) async {
      if (label.isEmpty) {
        if (id.isFake) store.execute(removeItem(id));
      } else {
        final item = store.evaluate(todoList.getItem(id));
        if (label == item.label) return;
        if (id.isFake) {
          store.execute(addItem(label));
        } else {
          store.execute(changeItem(id, label));
        }
      }
    });
  }
}
