import 'package:demo_core/demo_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/src/clerk_helpers/clerk.dart';
import 'package:flutter_demo/src/utils/build_context_utils.dart';
import 'package:flutter_demo/src/widgets/todo_list_item_text_field.dart';

class TodoListItem extends StatelessWidget {
  const TodoListItem({this.id, Key key}) : super(key: key);

  final TodoItemId id;

  @override
  Widget build(BuildContext _) {
    return StoreBuilder(
      builder: (context, store) {
        final todoList = context.resolve<TodoListReader>();
        final toggleItem = context.resolve<ToggleItem>();
        final commitItemChange = context.resolve<CommitItemChange>();
        final removeItem = context.resolve<RemoveItem>();

        final item = store.read(todoList.getItem(id));

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Checkbox(
              value: item.isDone,
              onChanged: store
                  .bindUnary((isDone) => toggleItem(item.id, isDone: isDone)),
            ),
            Expanded(
              child: TodoListItemTextField(
                item: item,
                onSubmitted: store
                    .bindUnary((value) => commitItemChange(item.id, value)),
              ),
            ),
            IconButton(
              icon: Icon(Icons.remove_circle_outline),
              onPressed: store.bind(() => removeItem(item.id)),
            ),
          ],
        );
      },
    );
  }
}
