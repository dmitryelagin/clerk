import 'todo_item.dart';

class TodoInitResponse {
  TodoInitResponse(this.items);

  final Iterable<TodoItem> items;
}
