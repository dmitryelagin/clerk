import 'package:clerk/clerk.dart';

import '../models/todo_item_id.dart';
import 'stop_item_change.dart';

mixin CommitItemChange on StopItemChange {
  Action commitItemChange(TodoItemId id, String label, [int keyCode]) =>
      Action((store) {
        final isBlur = keyCode == null;
        final isEnter = keyCode == 13;
        final isEsc = keyCode == 27;
        final isCommit = isBlur || isEnter || isEsc;

        if (!isCommit) return;
        if (store.evaluate(todoList.isNotChangingItem(id))) return;

        if (isBlur || isEnter) {
          store.assign(todoList.changeItem(id, label));
        }
        store.execute(stopItemChange());
      });
}
