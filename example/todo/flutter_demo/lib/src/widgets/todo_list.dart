import 'package:demo_core/demo_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/src/clerk_helpers/clerk.dart';
import 'package:flutter_demo/src/utils/build_context_utils.dart';
import 'package:flutter_demo/src/widgets/todo_list_item.dart';

class TodoList extends StatelessWidget {
  const TodoList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext _) {
    return StoreBuilder(
      builder: (context, store) {
        final todoList = context.resolve<TodoListReader>();
        final startItemAdd = context.resolve<StartItemAdd>();

        return Scaffold(
          appBar: AppBar(
            title: const Text('TODO'),
          ),
          body: ListView(
            children: [
              for (final item in store.read(todoList.getItems()))
                TodoListItem(key: Key(item.id.value.toString()), item: item),
            ],
          ),
          floatingActionButton: store.read(todoList.isAddingAvailable())
              ? FloatingActionButton(
                  tooltip: 'Add new TODO',
                  onPressed: store.bind(startItemAdd),
                  child: Icon(Icons.add),
                )
              : null,
        );
      },
    );
  }
}
