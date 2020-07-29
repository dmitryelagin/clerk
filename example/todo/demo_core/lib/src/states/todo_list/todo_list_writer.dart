import 'package:clerk/clerk.dart';

import '../../models/todo_item.dart';
import '../../models/todo_item_id.dart';
import '../../models/todo_item_utils.dart';
import '../../models/todo_validity.dart';
import 'todo_list_accumulator.dart';

mixin TodoListWriter<A extends TodoListAccumulator> {
  Apply<A> replaceItems(Iterable<TodoItem> items) =>
      (acc) => acc..items.replaceRange(0, acc.items.length, items);

  Apply<A> addItem(TodoItemId id, String label, {bool isDone = false}) =>
      (acc) => acc..items.add(TodoItem(id, label, isDone: isDone));

  Apply<A> removeItem(TodoItemId id) =>
      (acc) => acc..items.removeWhere((item) => item.id.value == id.value);

  Apply<A> changeItem(TodoItemId id, String label) =>
      updateItem(id, (item) => item.update(label: label));

  Apply<A> validateItem(TodoItemId id, TodoValidity validity) =>
      updateItem(id, (item) => item.update(validity: validity));

  Apply<A> resetItemValidity(TodoItemId id) =>
      updateItem(id, (item) => item.update(validity: const TodoValidity()));

  Apply<A> toggleItem(TodoItemId id, {bool isDone}) =>
      updateItem(id, (item) => item.update(isDone: isDone ?? !item.isDone));

  Apply<A> setItemIsPending(TodoItemId id) =>
      updateItem(id, (item) => item.update(isPending: true));

  Apply<A> setItemIsSynchronized(TodoItemId id) =>
      updateItem(id, (item) => item.update(isPending: false));

  Apply<A> updateItem(TodoItemId id, TodoItem Function(TodoItem) update) =>
      (acc) {
        final item = acc.items.firstWhere((item) => item.id.value == id.value);
        final index = acc.items.indexOf(item);
        return acc..items.replaceRange(index, index + 1, [update(item)]);
      };
}
