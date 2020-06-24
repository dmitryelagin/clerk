import 'package:demo_core/demo_core.dart';
import 'package:flutter/material.dart';

class TodoListItemControl extends StatelessWidget {
  const TodoListItemControl({
    @required this.item,
    @required this.onRetry,
    @required this.onRemove,
    Key key,
  }) : super(key: key);

  final TodoItem item;
  final void Function() onRetry;
  final void Function() onRemove;

  @override
  Widget build(BuildContext _) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (item.validity is AddItemFailure)
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: onRetry,
          ),
        IconButton(
          icon: Icon(Icons.remove_circle_outline),
          onPressed: onRemove,
        ),
      ],
    );
  }
}
