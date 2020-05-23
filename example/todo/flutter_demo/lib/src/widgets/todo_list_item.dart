import 'package:demo_core/demo_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/src/clerk_helpers/store_builder.dart';
import 'package:flutter_demo/src/modules/todo_module.dart';

abstract class TodoListItemAction
    implements ChangeItem, ToggleItem, RemoveItem {}

class TodoListItem extends StatelessWidget {
  const TodoListItem({Key key, this.id}) : super(key: key);

  final TodoItemId id;

  @override
  Widget build(BuildContext _) {
    return StoreBuilder(
      builder: (_, store) {
        final item = store.evaluate(todoList.getItem(id));
        return Row(
          children: [
            Checkbox(
              value: item.isDone,
              onChanged: (isDone) {
                store.execute(action.toggleItem(id, isDone: isDone));
              },
            ),
            Expanded(
              child: TextField(
                autofocus: store.evaluate(todoList.isAddingItem(id)),
                controller: TextEditingController(text: item.label),
                style: const TextStyle(fontSize: 20),
                onSubmitted: (value) {
                  store.execute(action.changeItem(id, value));
                },
              ),
            ),
            IconButton(
              icon: Icon(Icons.remove_circle_outline),
              onPressed: () {
                store.execute(action.removeItem(id));
              },
            ),
          ],
        );
      },
    );
  }
}
