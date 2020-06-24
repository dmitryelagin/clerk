import 'package:demo_core/demo_core.dart';
import 'package:flutter/material.dart';

class TodoListItemControl extends StatelessWidget {
  const TodoListItemControl({
    @required this.item,
    @required this.onRevert,
    @required this.onRetry,
    @required this.onRemove,
    Key key,
  }) : super(key: key);

  final TodoItem item;
  final void Function() onRevert;
  final void Function() onRetry;
  final void Function() onRemove;

  bool get _canRevert => item.validity is ChangeItemFailure;

  bool get _canRetry =>
      item.validity is AddItemFailure || item.validity is ChangeItemFailure;

  @override
  Widget build(BuildContext _) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (_canRevert)
          IconButton(
            icon: const Icon(Icons.undo),
            onPressed: onRevert,
          ),
        if (_canRetry)
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
