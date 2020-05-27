import 'package:demo_core/demo_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/src/clerk_helpers/clerk.dart';
import 'package:flutter_demo/src/utils/build_context_utils.dart';
import 'package:flutter_demo/src/widgets/todo_list_item.dart';

class TodoList extends StatelessWidget {
  const TodoList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreBuilder(
      builder: (_, store) {
        final todoList = context.resolve<TodoListSelector>();
        final startItemAdd = context.resolve<StartItemAdd>();

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
                  tooltip: 'Increment',
                  onPressed: () {
                    store.execute(startItemAdd());
                  },
                  child: Icon(Icons.add),
                )
              : null,
        );
      },
    );
  }
}
