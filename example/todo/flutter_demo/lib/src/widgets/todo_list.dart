import 'package:demo_core/demo_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/src/widgets/todo_list_item_smart.dart';

class TodoList extends StatelessWidget {
  const TodoList({
    @required this.itemsIds,
    @required this.onAdd,
    @required this.onRefresh,
    this.validity = Validity.valid,
    this.isPending = false,
    this.isAddingAvailable = false,
    Key key,
  }) : super(key: key);

  final Iterable<TodoItemId> itemsIds;
  final Validity validity;
  final bool isPending;
  final bool isAddingAvailable;

  final Future<void> Function() onRefresh;
  final void Function() onAdd;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('TODO'),
      ),
      body: Stack(
        children: [
          if (!isPending && !validity.isValid)
            Center(
              child: Text(
                validity.message,
                style: TextStyle(color: theme.errorColor),
              ),
            ),
          if (validity.isValid && itemsIds.isEmpty)
            Center(
              child: Text(
                'You do not have any TODOs',
                style: theme.textTheme.subtitle1,
              ),
            ),
          RefreshIndicator(
            onRefresh: onRefresh,
            child: ListView(
              children: [
                if (validity.isValid)
                  for (final id in itemsIds)
                    TodoListItem(key: Key(id.toString()), id: id),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: isAddingAvailable
          ? FloatingActionButton(
              tooltip: 'Add new TODO',
              onPressed: onAdd,
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}
