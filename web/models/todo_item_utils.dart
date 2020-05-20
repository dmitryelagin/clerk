import 'todo_item.dart';

extension TodoItemUtils on TodoItem {
  TodoItem update({String label, bool isChecked}) =>
      TodoItem(id, label ?? this.label, isChecked: isChecked ?? this.isChecked);
}
