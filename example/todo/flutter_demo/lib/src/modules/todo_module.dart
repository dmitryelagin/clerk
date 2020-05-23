import 'package:demo_core/demo_core.dart';
import 'package:flutter_demo/src/modules/todo_action_factory.dart';

final TodoListManager todoListManager = TodoListManager();
final TodoListSelectorFactory todoList = todoListManager;
final TodoActionFactory action =
    TodoActionFactory(todoListManager, TodoLoader());
