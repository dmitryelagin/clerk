import 'package:demo_core/demo_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/src/clerk_helpers/clerk.dart';
import 'package:flutter_demo/src/utils/build_context_utils.dart';
import 'package:flutter_demo/src/widgets/todo_list_item_text_field.dart';

class TodoListItem extends StatelessWidget {
  const TodoListItem({this.id, Key key}) : super(key: key);

  final TodoItemId id;

  @override
  Widget build(BuildContext context) {
    return StoreBuilder(
      builder: (_, store) {
        final todoList = context.resolve<TodoListSelector>();
        final toggleItem = context.resolve<ToggleItem>();
        final commitItemChange = context.resolve<CommitItemChange>();
        final removeItem = context.resolve<RemoveItem>();

        final item = store.evaluate(todoList.getItem(id));

        return Row(
          children: [
            Checkbox(
              value: item.isDone,
              onChanged: (isDone) {
                store.execute(toggleItem(item.id, isDone: isDone));
              },
            ),
            Expanded(
              child: TodoListItemTextField(
                item: item,
                onSubmitted: (value) {
                  store.execute(commitItemChange(item.id, value));
                },
              ),
            ),
            IconButton(
              icon: Icon(Icons.remove_circle_outline),
              onPressed: () {
                store.execute(removeItem(item.id));
              },
            ),
          ],
        );
      },
    );
  }
}
