import 'todo_item_id.dart';

extension TodoItemIdUtils on TodoItemId {
  bool get isFake => this == TodoItemId.fake;
}
