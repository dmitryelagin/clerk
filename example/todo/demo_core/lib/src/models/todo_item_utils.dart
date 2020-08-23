import 'todo_item.dart';
import 'validity.dart';

extension TodoItemUtils on TodoItem {
  TodoItem update({
    String label,
    bool isDone,
    bool isPending,
    Validity validity,
  }) {
    return TodoItem(
      id,
      label ?? this.label,
      isDone: isDone ?? this.isDone,
      isPending: isPending ?? this.isPending,
      validity: validity ?? this.validity,
    );
  }

  bool equals(TodoItem other) =>
      id == other.id &&
      label == other.label &&
      isDone == other.isDone &&
      isPending == other.isPending &&
      validity == other.validity;
}
