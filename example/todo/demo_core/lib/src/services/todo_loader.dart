import 'dart:math';

import '../models/todo_init_response.dart';
import '../models/todo_item.dart';
import '../models/todo_item_id.dart';

part 'todo_loader_stub.dart';

abstract class TodoLoader {
  factory TodoLoader() = _TodoLoaderStub;

  Future<TodoInitResponse> initApp();
  Future<TodoItemId> addItem(String label, {bool isDone});
  Future<void> changeItem(TodoItemId id, {String label, bool isDone});
  Future<void> removeItem(TodoItemId id);
}
