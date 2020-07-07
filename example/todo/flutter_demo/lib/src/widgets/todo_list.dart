import 'package:demo_core/demo_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/src/widgets/todo_list_item_smart.dart';

class TodoList extends StatelessWidget {
  const TodoList({
    @required this.itemsIds,
    @required this.isAddingAvailable,
    @required this.onAdd,
    Key key,
  }) : super(key: key);

  final Iterable<TodoItemId> itemsIds;
  final bool isAddingAvailable;

  final void Function() onAdd;

  @override
  Widget build(BuildContext _) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TODO'),
      ),
      body: itemsIds.isNotEmpty
          ? ListView(
              children: [
                for (final id in itemsIds)
                  TodoListItem(key: Key(id.toString()), id: id),
              ],
            )
          : const Center(
              child: Text(
                'You do not have any TODOs',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            ),
      floatingActionButton: isAddingAvailable
          ? FloatingActionButton(
              tooltip: 'Add new TODO',
              onPressed: onAdd,
              child: Icon(Icons.add),
            )
          : null,
    );
  }
}
