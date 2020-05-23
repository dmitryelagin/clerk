import 'package:clerk/clerk.dart';

import '../../models/todo_item.dart';
import '../../models/todo_item_id.dart';
import '../../models/todo_item_utils.dart';
import 'todo_list_accumulator.dart';

mixin TodoListWriterFactory<A extends TodoListAccumulator> {
  Writer<A, A> replaceItems(Iterable<TodoItem> items) =>
      (acc) => acc..items.replaceRange(0, acc.items.length, items);

  Writer<A, A> addItem(TodoItemId id, {String label = '', bool isDone}) =>
      (acc) => acc..items.add(TodoItem(id, label, isDone: isDone ?? false));

  Writer<A, A> removeItem(TodoItemId id) =>
      (acc) => acc..items.removeWhere((item) => item.id.value == id.value);

  Writer<A, A> changeItem(TodoItemId id, String label) =>
      updateItem(id, (item) => item.update(label: label));

  Writer<A, A> toggleItem(TodoItemId id, {bool isDone}) =>
      updateItem(id, (item) => item.update(isDone: isDone ?? !item.isDone));

  Writer<A, A> updateItem(TodoItemId id, TodoItem Function(TodoItem) update) =>
      (acc) {
        final item = acc.items.firstWhere((item) => item.id.value == id.value);
        final index = acc.items.indexOf(item);
        return acc..items.replaceRange(index, index + 1, [update(item)]);
      };
}
