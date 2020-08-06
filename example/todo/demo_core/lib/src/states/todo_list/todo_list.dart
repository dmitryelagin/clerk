import '../../models/todo_item.dart';
import '../../models/todo_item_id.dart';
import '../../models/todo_item_utils.dart';
import '../../models/todo_validity.dart';

class TodoList {
  final List<TodoItem> _items = [];

  bool isPendingItem(TodoItemId id) => getItem(id).isPending;

  TodoItem getItem(TodoItemId id) =>
      _items.firstWhere((item) => item.id.value == id.value);

  Iterable<TodoItem> getItems() => List.unmodifiable(_items);

  void replaceItems(Iterable<TodoItem> updatedItems) {
    _items.replaceRange(0, _items.length, updatedItems);
  }

  void addItem(TodoItemId id, String label, {bool isDone = false}) {
    _items.add(TodoItem(id, label, isDone: isDone));
  }

  void removeItem(TodoItemId id) {
    _items.removeWhere((item) => item.id.value == id.value);
  }

  void changeItem(TodoItemId id, String label) {
    updateItem(id, (item) => item.update(label: label));
  }

  void validateItem(TodoItemId id, TodoValidity validity) {
    updateItem(id, (item) => item.update(validity: validity));
  }

  void resetItemValidity(TodoItemId id) {
    updateItem(id, (item) => item.update(validity: const TodoValidity()));
  }

  void toggleItem(TodoItemId id, {bool? isDone}) {
    updateItem(id, (item) => item.update(isDone: isDone ?? !item.isDone));
  }

  void setItemIsPending(TodoItemId id) {
    updateItem(id, (item) => item.update(isPending: true));
  }

  void setItemIsSynchronized(TodoItemId id) {
    updateItem(id, (item) => item.update(isPending: false));
  }

  void updateItem(TodoItemId id, TodoItem Function(TodoItem) update) {
    final item = _items.firstWhere((item) => item.id.value == id.value);
    final index = _items.indexOf(item);
    _items.replaceRange(index, index + 1, [update(item)]);
  }
}
