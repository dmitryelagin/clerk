import '../services/todo_loader.dart';
import '../states/todo_list/todo_list.dart';

class Init {
  const Init(this._loader);

  final TodoLoader _loader;

  Future<void> call(TodoList todoList) async {
    try {
      final data = await _loader.initApp();
      todoList.replaceItems(data.items);
    } on Exception catch (e) {
      print(e);
    }
  }
}
