import 'package:clerk/clerk.dart';

import '../states/todo_list/todo_list_state.dart';

Store createTodoStore() => Store()..composer.add(createTodoListState());
