import '../../demo_core.dart';
import '../models/todo_item_id.dart';
import '../models/todo_item_id_utils.dart';
import '../states/todo_list/todo_list.dart';
import 'add_item.dart';
import 'change_item.dart';
import 'remove_item.dart';

class CommitItem {
  const CommitItem(this._addItem, this._changeItem, this._removeItem);

  final AddItem _addItem;
  final ChangeItem _changeItem;
  final RemoveItem _removeItem;

  void call(TodoList todoList, TodoItemId id, [String label]) {
    if (label != null && label.isEmpty) {
      if (id.isFake) _removeItem(todoList, id);
    } else {
      if (id.isFake) {
        _addItem(todoList, label);
      } else {
        _changeItem(todoList, id, label);
      }
    }
  }
}
