import 'package:demo_core/demo_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/src/utils/store_state.dart';
import 'package:flutter_demo/src/widgets/todo_list_item.dart' as simple;
import 'package:summon/summon.dart';

class TodoListItem extends StatefulWidget {
  const TodoListItem({
    @required this.id,
    Key key,
  }) : super(key: key);

  final TodoItemId id;

  @override
  _TodoListItemState createState() => _TodoListItemState();
}

class _TodoListItemState extends State<TodoListItem>
    with StoreState, InjectorState {
  TodoListReader get _todoList => get();
  ToggleItem get _toggleItem => get();
  CommitItem get _commitItem => get();
  RemoveItem get _removeItem => get();
  RevertItemValidity get _revertItemValidity => get();

  @override
  Widget build(BuildContext _) {
    return simple.TodoListItem(
      key: widget.key,
      item: store.readUnary(_todoList.getItem, widget.id),
      shouldAutofocus: store.readUnary(_todoList.isFakeItem, widget.id),
      onChange: _onChange,
      onToggle: _onToggle,
      onRemove: _onRemove,
      onFocus: _onFocus,
      onRetry: _onRetry,
    );
  }

  void _onChange(String label) {
    store.applyBinary(_commitItem.call, widget.id, label);
  }

  void _onToggle(bool isDone) {
    store.applyBinary(_toggleItem.call, widget.id, isDone);
  }

  Future<bool> _onRemove() async {
    final id = widget.id;
    await store.applyUnary(_removeItem.call, id);
    return !store.readUnary(_todoList.hasItem, id);
  }

  void _onFocus() {
    store.applyUnary(_revertItemValidity.call, widget.id);
  }

  void _onRetry() {
    store.applyUnary(_commitItem.call, widget.id);
  }
}
