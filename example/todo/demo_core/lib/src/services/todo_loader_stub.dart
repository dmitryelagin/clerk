part of 'todo_loader.dart';

class _TodoLoaderStub implements TodoLoader {
  static Random _random = Random();

  static int _lastItemId = 0;

  static String get _randomWord {
    const words = 'jellyfish meat cuddly hot influence inquisitive earthquake '
        'cap button tap whirl blade graceful juice tall dark cart unnatural '
        'close kneel visit chance sprout wretched natural unbiased actor fuel';
    final shuffledWords = words.split(' ')..shuffle(_random);
    return shuffledWords.first;
  }

  static TodoItem get _randomItem => TodoItem(
        _nextItemId,
        List.generate(_random.nextInt(3) + 2, (_) => _randomWord).join(' '),
        isDone: _random.nextBool(),
      );

  static TodoItemId get _nextItemId => TodoItemId(_lastItemId += 1);

  static Future<T> _requestData<T>(
    String type, {
    T data,
    bool canReturnError = false,
    int minResponseLag = 100,
  }) {
    final milliseconds = (_random.nextDouble() * 200 + minResponseLag).round();
    final duration = Duration(milliseconds: milliseconds);
    return Future<void>.delayed(duration).then((_) {
      final shouldReturnData = _random.nextDouble() > 0.25;
      if (!canReturnError || shouldReturnData) return data;
      throw Exception();
    });
  }

  @override
  Future<TodoInitResponse> initApp() => _requestData(
        'initApp',
        data: TodoInitResponse(
          List.generate(_random.nextInt(8), (_) => _randomItem),
        ),
        minResponseLag: 500,
      );

  @override
  Future<TodoItemId> addItem(String label, {bool isDone}) =>
      _requestData('addItem', data: _nextItemId, canReturnError: true);

  @override
  Future<void> changeItem(TodoItemId id, {String label, bool isDone}) =>
      _requestData('changeItem', canReturnError: true);

  @override
  Future<void> removeItem(TodoItemId id) =>
      _requestData('removeItem', canReturnError: true);
}
