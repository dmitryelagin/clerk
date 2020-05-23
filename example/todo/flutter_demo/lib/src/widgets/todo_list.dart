import 'package:demo_core/demo_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/src/clerk_helpers/store_builder.dart';
import 'package:flutter_demo/src/modules/todo_module.dart';
import 'package:flutter_demo/src/widgets/todo_list_item.dart';

abstract class TodoListAction implements StartItemAdd {}

class TodoList extends StatelessWidget {
  const TodoList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext _) {
    return StoreBuilder(
      builder: (_, store) {
        final ids = store.evaluate(todoList.getItemsIds());
        final isAddingAvailable = store.evaluate(todoList.isAddingAvailable());
        return Scaffold(
          appBar: AppBar(
            title: const Text('TODO'),
          ),
          body: ListView(
            children: [
              for (final id in ids)
                TodoListItem(key: Key(id.value.toString()), id: id),
            ],
          ),
          floatingActionButton: isAddingAvailable
              ? FloatingActionButton(
                  onPressed: () {
                    store.execute(action.startItemAdd());
                  },
                  tooltip: 'Increment',
                  child: Icon(Icons.add),
                )
              : null,
        );
      },
    );
  }
}
