// ignore_for_file: avoid_positional_boolean_parameters

import '../../models/todo_item.dart';
import '../../models/todo_item_id.dart';
import '../../models/todo_item_utils.dart';
import 'todo_list_accumulator.dart';

typedef TodoItemUpdate = TodoItem Function(TodoItem);

mixin TodoListWriter<A extends TodoListAccumulator> {
  static const _itemInitialLabel = '';

  A replaceItems(A acc, Iterable<TodoItem> items) =>
      acc..items.replaceRange(0, acc.items.length, items);

  A addItem(A acc, TodoItemId id, [String label = _itemInitialLabel]) =>
      acc..items.add(TodoItem(id, label));

  A removeItem(A acc, TodoItemId id) =>
      acc..items.removeWhere((item) => item.id.value == id.value);

  A changeItem(A acc, TodoItemId id, String label) =>
      _updateItem(acc, id, (item) => item.update(label: label));

  A toggleItem(A acc, TodoItemId id, bool isChecked) => _updateItem(
        acc,
        id,
        (item) => item.update(isChecked: isChecked ?? !item.isChecked),
      );

  A startItemChange(A acc, TodoItemId id) => acc..editingItemId = id;

  A stopItemChange(A acc) => acc..editingItemId = null;

  A _updateItem(A acc, TodoItemId id, TodoItemUpdate update) {
    final item = acc.items.firstWhere((item) => item.id.value == id.value);
    final index = acc.items.indexOf(item);
    return acc..items.replaceRange(index, index + 1, [update(item)]);
  }
}
