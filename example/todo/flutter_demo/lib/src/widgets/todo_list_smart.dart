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

class _TodoListState extends State<TodoList> with StoreState, InjectorState {
  TodoListReader get _todoList => get();
  StartItemAdd get _startItemAdd => get();
  FetchItems get _fetchItems => get();

  @override
  Widget build(BuildContext _) {
    return simple.TodoList(
      itemsIds: store.read(_todoList.getItemsIds),
      validity: store.read(_todoList.getValidity),
      isPending: store.read(_todoList.isPending),
      isAddingAvailable: store.read(_todoList.isAddingAvailable),
      onAdd: _onAdd,
      onRefresh: _onRefresh,
    );
  }

  void _onAdd() {
    store.apply(_startItemAdd.call);
  }

  Future<void> _onRefresh() async {
    await store.apply(_fetchItems.call);
  }
}
