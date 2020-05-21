import 'package:clerk/clerk.dart';

import '../models/todo_item_id.dart';
import 'add_item.dart';
import 'change_item.dart';
import 'stop_item_change.dart';

mixin CommitItemChange on CancelItemChange, AddItem, ChangeItem {
  Action commitItemChange(TodoItemId id, String label, [int keyCode]) =>
      Action((store) async {
        final isBlur = keyCode == null;
        final isEnter = keyCode == 13;
        final isEsc = keyCode == 27;
        final isCommit = isBlur || isEnter || isEsc;
        final isAdding = TodoItemId.isFake(id);

        if (!isCommit) return;
        if (store.evaluate(todoList.isNotChangingItem(id))) return;

        if (isEsc) store.execute(cancelItemChange());
        if (!isEsc && isAdding) store.execute(addItem(label));
        if (!isEsc && !isAdding) store.execute(changeItem(id, label));
      });
}
