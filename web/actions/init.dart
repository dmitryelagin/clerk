import 'package:clerk/clerk.dart';

import '../services/todo_loader.dart';
import '../states/todo_list/todo_list_state.dart';

mixin Init {
  TodoLoader get loader;
  TodoListManager get todoList;

  Action init() => Action((store) async {
        try {
          final data = await loader.initApp();
          store.assign(todoList.replaceItems(data.items));
        } on Exception catch (exception) {
          print(exception);
        }
      });
}
