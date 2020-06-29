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
    final random = Random();
    final milliseconds = (random.nextDouble() * 200 + minResponseLag).round();
    final duration = Duration(milliseconds: milliseconds);
    return Future<void>.delayed(duration).then((_) {
      final shouldReturnData = random.nextDouble() > 0.25;
      if (!canReturnError || shouldReturnData) return data;
      throw Exception();
    });
  }

  @override
  Future<TodoInitResponse> initApp() => _requestData(
        'initApp',
        TodoInitResponse([
          TodoItem(_nextItemId, 'Test label 1'),
          TodoItem(_nextItemId, 'Test label 2', isDone: true),
          TodoItem(_nextItemId, 'Test label 3'),
          TodoItem(_nextItemId, 'Test label 4', isDone: true),
        ]),
        minResponseLag: 300,
      );

  @override
  Future<TodoItemId> addItem(String label, {bool? isDone}) =>
      _requestData('addItem', _nextItemId, canReturnError: true);

  @override
  Future<void> changeItem(TodoItemId id, {String? label, bool? isDone}) =>
      _requestData('changeItem', null, canReturnError: true);

  @override
  Future<void> removeItem(TodoItemId id) =>
      _requestData('removeItem', null, canReturnError: true);
}
