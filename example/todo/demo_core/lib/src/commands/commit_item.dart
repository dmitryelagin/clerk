import 'package:clerk/clerk.dart';

import '../../demo_core.dart';
import '../models/todo_item_id.dart';
import '../models/todo_item_id_utils.dart';
import 'add_item.dart';
import 'change_item.dart';
import 'remove_item.dart';

class CommitItem {
  const CommitItem(this._addItem, this._changeItem, this._removeItem);

  final AddItem _addItem;
  final ChangeItem _changeItem;
  final RemoveItem _removeItem;

  Execute call(TodoItemId id, [String label]) {
    return (store) async {
      if (label != null && label.isEmpty) {
        if (id.isFake) store.execute(_removeItem(id));
      } else {
        if (id.isFake) {
          store.execute(_addItem(label));
        } else {
          store.execute(_changeItem(id, label));
        }
      }
    };
  }
}
