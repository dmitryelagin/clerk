import 'package:clerk/clerk.dart';

import '../../demo_core.dart';
import '../models/todo_item_id.dart';
import '../models/todo_item_id_utils.dart';
import 'add_item.dart';
import 'change_item.dart';
import 'remove_item.dart';

class CommitItemChange {
  const CommitItemChange(this._addItem, this._changeItem, this._removeItem);

  final AddItem _addItem;
  final ChangeItem _changeItem;
  final RemoveItem _removeItem;

  Action call(TodoItemId id, String label) {
    return Action((store) async {
      if (label.isEmpty) {
        if (id.isFake) store.execute(_removeItem(id));
      } else {
        store.execute(id.isFake ? _addItem(label) : _changeItem(id, label));
      }
    });
  }
}
