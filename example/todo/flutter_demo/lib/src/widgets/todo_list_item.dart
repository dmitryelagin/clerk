import 'package:demo_core/demo_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/src/clerk_helpers/clerk.dart';
import 'package:flutter_demo/src/utils/build_context_utils.dart';
import 'package:flutter_demo/src/widgets/todo_list_item_text_field.dart';

class TodoListItem extends StatelessWidget {
  const TodoListItem({this.item, Key key}) : super(key: key);

  final TodoItem item;

  @override
  Widget build(BuildContext _) {
    return StoreBuilder(
      builder: (context, store) {
        final toggleItem = context.resolve<ToggleItem>();
        final commitItemChange = context.resolve<CommitItemChange>();
        final removeItem = context.resolve<RemoveItem>();
        final resetItemValidity = context.resolve<ResetItemValidity>();

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Checkbox(
              value: item.isDone,
              onChanged: store.bindUnary((isDone) => [
                    resetItemValidity(item.id),
                    toggleItem(item.id, isDone: isDone),
                  ]),
            ),
            Expanded(
              child: TodoListItemTextField(
                item: item,
                onFocus: store.bind(() => [resetItemValidity(item.id)]),
                onSubmitted: store
                    .bindUnary((value) => [commitItemChange(item.id, value)]),
              ),
            ),
            IconButton(
              icon: Icon(Icons.remove_circle_outline),
              onPressed: store.bind(() => [
                    resetItemValidity(item.id),
                    removeItem(item.id),
                  ]),
            ),
          ],
        );
      },
    );
  }
}
