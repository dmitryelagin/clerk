import 'package:demo_core/demo_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/src/clerk_helpers/clerk.dart';
import 'package:flutter_demo/src/utils/build_context_utils.dart';
import 'package:flutter_demo/src/widgets/todo_list_item.dart' as simple;

class TodoListItem extends StatefulWidget {
  const TodoListItem({
    @required this.item,
    Key key,
  }) : super(key: key);

  final TodoItem item;

  @override
  _TodoListItemState createState() => _TodoListItemState();
}

class _TodoListItemState extends StoreState<TodoListItem> {
  simple.TodoListItemAction _action;

  TodoItemId get _itemId => widget.item.id;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final toggleItem = context.resolve<ToggleItem>();
    final commitItem = context.resolve<CommitItem>();
    final removeItem = context.resolve<RemoveItem>();
    final resetItemValidity = context.resolve<ResetItemValidity>();

    _action = simple.TodoListItemAction(
      onChange: (label) => store.execute(commitItem(_itemId, label)),
      onToggle: (isDone) => store.execute(toggleItem(_itemId, isDone: isDone)),
      onRemove: () => store.execute(removeItem(_itemId)),
      onFocus: () => store.execute(resetItemValidity(_itemId)),
      onRetry: () => store.execute(commitItem(_itemId)),
    );
  }

  @override
  Widget build(BuildContext _) {
    return simple.TodoListItem(
      key: widget.key,
      item: widget.item,
      action: _action,
    );
  }
}
