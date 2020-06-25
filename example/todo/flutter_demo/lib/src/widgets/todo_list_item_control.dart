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

  bool get _canRetry =>
      item.validity is AddItemFailure || item.validity is ChangeItemFailure;

  @override
  Widget build(BuildContext _) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
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
