import 'package:demo_core/demo_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/src/clerk_helpers/clerk.dart';
import 'package:flutter_demo/src/utils/build_context_utils.dart';
import 'package:flutter_demo/src/widgets/todo_list.dart' as simple;

class TodoList extends StatefulWidget {
  const TodoList({Key key}) : super(key: key);

  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends StoreState<TodoList> {
  TodoListReader _todoList;
  simple.TodoListAction _action;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _todoList = context.resolve<TodoListReader>();

    final startItemAdd = context.resolve<StartItemAdd>();

    _action = simple.TodoListAction(
      onAdd: () => store.execute(startItemAdd()),
    );
  }

  @override
  Widget build(BuildContext _) {
    return simple.TodoList(
      key: widget.key,
      items: store.read(_todoList.getItems()),
      isAddingAvailable: store.read(_todoList.isAddingAvailable()),
      action: _action,
    );
  }
}
