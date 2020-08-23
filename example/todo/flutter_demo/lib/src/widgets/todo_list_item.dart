import 'package:demo_core/demo_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/src/widgets/manageable_list_item_text_field.dart';

class TodoListItem extends StatelessWidget {
  const TodoListItem({
    @required this.item,
    @required this.onChange,
    @required this.onToggle,
    @required this.onRemove,
    @required this.onFocus,
    @required this.onRetry,
    this.shouldAutofocus = false,
    Key key,
  }) : super(key: key);

  final TodoItem item;
  final bool shouldAutofocus;

  final Future<bool> Function() onRemove;
  final void Function(String) onChange;
  final void Function(bool) onToggle;
  final void Function() onFocus;
  final void Function() onRetry;

  DismissDirection get _direction => item.validity is RetryableValidity
      ? DismissDirection.horizontal
      : DismissDirection.endToStart;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Dismissible(
      key: key,
      direction: _direction,
      confirmDismiss: _confirmDismiss,
      background: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        color: theme.dividerColor,
        child: Row(
          children: const [
            Icon(Icons.refresh),
            Text('Retry'),
          ],
        ),
      ),
      secondaryBackground: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        color: theme.dividerColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            Text('Delete'),
            Icon(Icons.delete_outline),
          ],
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Checkbox(
            value: item.isDone,
            onChanged: onToggle,
          ),
          Expanded(
            child: ManageableListItemTextField(
              label: item.label,
              validity: item.validity,
              isPending: item.isPending,
              shouldAutofocus: shouldAutofocus,
              textColor: item.isDone ? theme.textTheme.caption.color : null,
              onFocus: onFocus,
              onChange: onChange,
            ),
          ),
        ],
      ),
    );
  }

  Future<bool> _confirmDismiss(DismissDirection direction) {
    if (direction == DismissDirection.endToStart) {
      return onRemove();
    } else {
      onRetry();
      return Future.value();
    }
  }
}
