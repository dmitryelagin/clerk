import 'package:demo_core/demo_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/src/widgets/todo_list_item_text_field.dart';

class TodoListItem extends StatelessWidget {
  const TodoListItem({
    @required this.item,
    @required this.onChange,
    @required this.onToggle,
    @required this.onRemove,
    @required this.onFocus,
    @required this.onRetry,
    Key key,
  }) : super(key: key);

  final TodoItem item;

  final void Function(String) onChange;
  final void Function(bool) onToggle;
  final void Function() onRemove;
  final void Function() onFocus;
  final void Function() onRetry;

  bool get _canRetry =>
      item.validity is AddItemFailure || item.validity is ChangeItemFailure;

  @override
  Widget build(BuildContext _) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Checkbox(
          value: item.isDone,
          onChanged: onToggle,
        ),
        Expanded(
          child: TodoListItemTextField(
            item: item,
            onFocus: onFocus,
            onChange: onChange,
          ),
        ),
        if (_canRetry)
          IconButton(
            icon: const Icon(Icons.refresh),
            splashColor: Colors.transparent,
            tooltip: 'Retry',
            onPressed: onRetry,
          ),
        IconButton(
          icon: const Icon(Icons.remove_circle_outline),
          tooltip: 'Remove',
          onPressed: onRemove,
        ),
      ],
    );
  }
}
