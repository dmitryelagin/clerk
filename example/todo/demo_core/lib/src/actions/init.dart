import 'package:clerk/clerk.dart';

import '../services/todo_loader.dart';
import '../states/todo_list/todo_list_state.dart';

abstract class Init {
  Action init();
}

mixin InitFactory implements Init {
  TodoLoader get loader;
  TodoListManager get todoList;

  @override
  Action init() {
    return Action((store) async {
      try {
        final data = await loader.initApp();
        store.assign(todoList.replaceItems(data.items));
      } on Exception catch (e) {
        print(e);
      }
    });
  }
}
