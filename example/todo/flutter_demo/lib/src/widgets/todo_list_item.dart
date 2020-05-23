import 'package:demo_core/demo_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/src/clerk_helpers/store_builder.dart';
import 'package:flutter_demo/src/modules/todo_module.dart';
import 'package:flutter_demo/src/widgets/todo_list_item_text_field.dart';

abstract class TodoListItemAction
    implements CommitItemChange, ToggleItem, RemoveItem {}

class TodoListItem extends StatelessWidget {
  const TodoListItem({this.id, Key key}) : super(key: key);

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
                store.execute(action.toggleItem(item.id, isDone: isDone));
              },
            ),
            Expanded(
              child: TodoListItemTextField(
                item: item,
                onSubmitted: (value) {
                  store.execute(action.commitItemChange(item.id, value));
                },
              ),
            ),
            IconButton(
              icon: Icon(Icons.remove_circle_outline),
              onPressed: () {
                store.execute(action.removeItem(item.id));
              },
            ),
          ],
        );
      },
    );
  }
}
