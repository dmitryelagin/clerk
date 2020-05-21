part of 'todo_loader.dart';

class _TodoLoaderStub implements TodoLoader {
  static int _lastItemId = 0;

  static TodoItemId get _nextItemId => TodoItemId(_lastItemId += 1);

  static Future<T> _requestData<T>(
    String type,
    T data, {
    bool canReturnError = false,
    int minResponseLag = 100,
  }) {
    print('Request: $type');
    final random = Random();
    final milliseconds = (random.nextDouble() * 200 + minResponseLag).round();
    final duration = Duration(milliseconds: milliseconds);
    return Future<void>.delayed(duration).then((_) {
      final shouldReturnData = random.nextDouble() > 0.2;
      if (!canReturnError || shouldReturnData) return data;
      throw Exception();
    });
  }

  @override
  Future<TodoInitResponse> initApp() => _requestData(
        'initApp',
        TodoInitResponse([
          TodoItem(_nextItemId, 'Test label 1', isDone: false),
          TodoItem(_nextItemId, 'Test label 2', isDone: true),
        ]),
        minResponseLag: 300,
      );

  @override
  Future<TodoItemId> addItem(String label) =>
      _requestData('addItem', _nextItemId);

  @override
  Future<void> changeItem(TodoItemId id, String label) =>
      _requestData('changeItem', null);

  @override
  Future<void> removeItem(TodoItemId id) => _requestData('removeItem', null);
}
