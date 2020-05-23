import 'package:clerk/clerk.dart';

import '../models/todo_item_id.dart';
import 'add_item.dart';
import 'change_item.dart';
import 'stop_item_change.dart';

mixin CommitItemChange on CancelItemChange, AddItem, ChangeItem {
  Action commitItemChange(TodoItemId id, String label, [int keyCode]) =>
      Action((store) async {
        final isSubmit = keyCode == null || keyCode == 13;
        final isCancel = keyCode == 27;
        final isAdding = store.evaluate(todoList.isAddingItem(id));

        if (!isSubmit && !isCancel) return;
        if (!store.evaluate(todoList.isChangingItem(id))) return;

        if (isCancel) store.execute(cancelItemChange());
        if (!isCancel && isAdding) store.execute(addItem(label));
        if (!isCancel && !isAdding) store.execute(changeItem(id, label));
      });
}
