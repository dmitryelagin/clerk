import 'package:demo_core/demo_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/src/widgets/todo_list_item_smart.dart';

class TodoList extends StatelessWidget {
  const TodoList({
    @required this.items,
    @required this.isAddingAvailable,
    @required this.action,
    Key key,
  }) : super(key: key);

  final Iterable<TodoItem> items;
  final bool isAddingAvailable;
  final TodoListAction action;

  @override
  Widget build(BuildContext _) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TODO'),
      ),
      body: ListView(
        children: [
          for (final item in items)
            TodoListItem(key: Key(item.id.value.toString()), item: item),
        ],
      ),
      floatingActionButton: isAddingAvailable
          ? FloatingActionButton(
              tooltip: 'Add new TODO',
              onPressed: action.onAdd,
              child: Icon(Icons.add),
            )
          : null,
    );
  }
}

class TodoListAction {
  const TodoListAction({
    @required this.onAdd,
  });

  final void Function() onAdd;
}
