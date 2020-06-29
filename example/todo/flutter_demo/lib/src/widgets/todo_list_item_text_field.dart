import 'package:demo_core/demo_core.dart';
import 'package:flutter/material.dart';

class TodoListItemTextField extends StatefulWidget {
  const TodoListItemTextField({
    @required this.item,
    @required this.onFocus,
    @required this.onChange,
    Key key,
  }) : super(key: key);

  final TodoItem item;
  final void Function() onFocus;
  final void Function(String) onChange;

  @override
  _TodoListItemTextFieldState createState() => _TodoListItemTextFieldState();
}

class _TodoListItemTextFieldState extends State<TodoListItemTextField> {
  final _focusNode = FocusNode();
  final _textController = TextEditingController();

  @override
  void initState() {
    _syncTextWithModel();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) return widget.onFocus();
      if (_textController.text.isEmpty) _syncTextWithModel();
      widget.onChange(_textController.text);
    });
    if (widget.item.id.isFake) _focusNode.requestFocus();
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext _) {
    return TextField(
      controller: _textController,
      decoration: InputDecoration(
        errorText: widget.item.isValid ? null : widget.item.validity.message,
        hintText: 'Enter what to do',
        suffixIcon: Visibility(
          visible: widget.item.isPending,
          child: const IgnorePointer(
            child: Icon(
              Icons.sync,
              color: Colors.lightBlue,
              semanticLabel: 'Synchronizing data...',
            ),
          ),
        ),
      ),
      focusNode: _focusNode,
      style: const TextStyle(fontSize: 20),
    );
  }

  void _syncTextWithModel() {
    _textController.text = widget.item.label;
  }
}
