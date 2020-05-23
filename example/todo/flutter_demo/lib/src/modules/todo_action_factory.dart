import 'package:demo_core/demo_core.dart';
import 'package:flutter_demo/src/widgets/todo_app.dart';
import 'package:flutter_demo/src/widgets/todo_list.dart';
import 'package:flutter_demo/src/widgets/todo_list_item.dart';

class TodoActionFactory
    with
        InitFactory,
        AddItemFactory,
        ChangeItemFactory,
        RemoveItemFactory,
        ToggleItemFactory,
        CommitItemChangeFactory,
        StartItemAddFactory
    implements TodoAppAction, TodoListAction, TodoListItemAction {
  TodoActionFactory(this.todoList, this.loader);

  @override
  final TodoListManager todoList;

  @override
  final TodoLoader loader;
}
