import 'package:clerk/clerk.dart';

import '../states/todo_list/todo_list_state.dart';

Store createTodoStore() => Store((builder) {
      builder.add(TodoListState());
    }, StoreSettings.standard);
