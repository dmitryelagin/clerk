import 'package:clerk/clerk.dart';

import '../../models/todo_item.dart';
import '../../models/todo_item_id.dart';
import '../../models/todo_item_utils.dart';
import 'todo_list_accumulator.dart';

mixin TodoListWriterFactory<A extends TodoListAccumulator> {
  static const _itemInitialLabel = '';

  Writer<A, A> replaceItems(Iterable<TodoItem> items) =>
      (acc) => acc..items.replaceRange(0, acc.items.length, items);

  Writer<A, A> addItem(TodoItemId id, [String label = _itemInitialLabel]) =>
      (acc) => acc..items.add(TodoItem(id, label));

  Writer<A, A> removeItem(TodoItemId id) =>
      (acc) => acc..items.removeWhere((item) => item.id.value == id.value);

  Writer<A, A> changeItem(TodoItemId id, String label) =>
      (acc) => _updateItem(acc, id, (item) => item.update(label: label));

  Writer<A, A> toggleItem(TodoItemId id, {bool isChecked}) =>
      (acc) => _updateItem(
            acc,
            id,
            (item) => item.update(isChecked: isChecked ?? !item.isChecked),
          );

  Writer<A, A> startItemChange(TodoItemId id) =>
      (acc) => acc..editingItemId = id;

  Writer<A, A> stopItemChange() => (acc) => acc..editingItemId = null;

  A _updateItem(A acc, TodoItemId id, TodoItem Function(TodoItem) update) {
    final item = acc.items.firstWhere((item) => item.id.value == id.value);
    final index = acc.items.indexOf(item);
    return acc..items.replaceRange(index, index + 1, [update(item)]);
  }
}
