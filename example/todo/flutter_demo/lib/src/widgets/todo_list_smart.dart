import 'package:demo_core/demo_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/src/utils/injector_state.dart';
import 'package:flutter_demo/src/widgets/todo_list.dart' as simple;

class TodoList extends StatefulWidget {
  const TodoList({Key key}) : super(key: key);

  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends InjectorState<TodoList> {
  TodoListReader _todoList;
  StartItemAdd _startItemAdd;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _todoList = injector.get();
    _startItemAdd = injector.get();
  }

  @override
  Widget build(BuildContext _) {
    return simple.TodoList(
      itemsIds: store.read(_todoList.getItemsIds()),
      isAddingAvailable: store.read(_todoList.isAddingAvailable()),
      onAdd: _onAdd,
    );
  }

  void _onAdd() {
    store.execute(_startItemAdd());
  }
}
