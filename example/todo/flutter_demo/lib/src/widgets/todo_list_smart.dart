import 'package:demo_core/demo_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/src/utils/store_state.dart';
import 'package:flutter_demo/src/widgets/todo_list.dart' as simple;
import 'package:summon/summon.dart';

class TodoList extends StatefulWidget {
  const TodoList({Key key}) : super(key: key);

  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends StoreState<TodoList> with InjectorState {
  TodoListReader get _todoList => get();
  StartItemAdd get _startItemAdd => get();

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
