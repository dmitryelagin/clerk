import 'package:clerk/clerk.dart';

import '../services/todo_loader.dart';
import '../states/todo_list/todo_list_state.dart';

class Init {
  const Init(this._todoList, this._loader);

  final TodoListManager _todoList;
  final TodoLoader _loader;

  Action call() {
    return Action((store) async {
      try {
        final data = await _loader.initApp();
        store.assign(_todoList.replaceItems(data.items));
      } on Exception catch (e) {
        print(e);
      }
    });
  }
}
