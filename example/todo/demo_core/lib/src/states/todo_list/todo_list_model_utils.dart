import '../../models/todo_item_utils.dart';
import 'todo_list_model.dart';

extension TodoListModelUtils on TodoListModel {
  bool equals(TodoListModel other) {
    if (validity != other.validity) return false;
    if (isPending != other.isPending) return false;
    if (items.length != other.items.length) return false;
    for (var i = 0; i < items.length; i += 1) {
      final first = items.elementAt(i);
      final second = other.items.elementAt(i);
      if (!first.equals(second)) return false;
    }
    return true;
  }
}
