import 'package:demo_core/demo_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/src/module_helpers/index.dart';
import 'package:flutter_demo/src/utils/store_state.dart';
import 'package:flutter_demo/src/widgets/todo_list_item.dart' as simple;

class TodoListItem extends StatefulWidget {
  const TodoListItem({
    @required this.id,
    Key key,
  }) : super(key: key);

  final TodoItemId id;

  @override
  _TodoListItemState createState() => _TodoListItemState();
}

class _TodoListItemState extends StoreState<TodoListItem> with InjectorState {
  TodoListReader get _todoList => get();
  ToggleItem get _toggleItem => get();
  CommitItem get _commitItem => get();
  RemoveItem get _removeItem => get();
  ResetItemValidity get _resetItemValidity => get();

  @override
  Widget build(BuildContext _) {
    return simple.TodoListItem(
      item: store.read(_todoList.getItem(widget.id)),
      onChange: _onChange,
      onToggle: _onToggle,
      onRemove: _onRemove,
      onFocus: _onFocus,
      onRetry: _onRetry,
    );
  }

  void _onChange(String label) {
    store.execute(_commitItem(widget.id, label));
  }

  void _onToggle(bool isDone) {
    store.execute(_toggleItem(widget.id, isDone: isDone));
  }

  void _onRemove() {
    store.execute(_removeItem(widget.id));
  }

  void _onFocus() {
    store.execute(_resetItemValidity(widget.id));
  }

  void _onRetry() {
    store.execute(_commitItem(widget.id));
  }
}
