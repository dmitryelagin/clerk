import 'dart:math';

import '../models/todo_init_response.dart';
import '../models/todo_item.dart';
import '../models/todo_item_id.dart';

abstract class TodoLoader {
  factory TodoLoader() = _TodoLoaderStub;

  Future<TodoInitResponse> initApp();
}

class _TodoLoaderStub implements TodoLoader {
  @override
  Future<TodoInitResponse> initApp() => _requestData(
        TodoInitResponse(const [
          TodoItem(TodoItemId(1), 'Test 1', isChecked: false),
          TodoItem(TodoItemId(2), 'Test 2', isChecked: true),
        ]),
        canReturnError: false,
        minResponseLag: 300,
      );

  Future<T> _requestData<T>(
    T data, {
    bool canReturnError = true,
    int minResponseLag = 100,
  }) {
    final random = Random();
    final milliseconds = (random.nextDouble() * 200 + minResponseLag).round();
    final duration = Duration(milliseconds: milliseconds);
    return Future<void>.delayed(duration).then((_) {
      final shouldReturnData = random.nextDouble() > 0.2;
      if (!canReturnError || shouldReturnData) return data;
      throw Exception();
    });
  }
}
