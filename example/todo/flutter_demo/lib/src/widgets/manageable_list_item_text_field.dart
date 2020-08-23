import 'package:demo_core/demo_core.dart';
import 'package:flutter/material.dart';

class ManageableListItemTextField extends StatefulWidget {
  const ManageableListItemTextField({
    @required this.label,
    @required this.onFocus,
    @required this.onChange,
    this.validity = Validity.valid,
    this.isPending = false,
    this.shouldAutofocus = false,
    this.textColor,
    Key key,
  }) : super(key: key);

  final String label;
  final Validity validity;
  final bool isPending;
  final bool shouldAutofocus;
  final Color textColor;

  final void Function() onFocus;
  final void Function(String) onChange;

  @override
  _ManageableListItemTextFieldState createState() =>
      _ManageableListItemTextFieldState();
}

class _ManageableListItemTextFieldState
    extends State<ManageableListItemTextField> {
  final _focusNode = FocusNode();
  final _textController = TextEditingController();

  static void _noop() {}

  @override
  void initState() {
    super.initState();
    _syncTextWithModel();
    _focusNode.addListener(() {
      setState(_noop);
      if (_focusNode.hasFocus) {
        widget.onFocus();
        return;
      }
      if (_textController.text.isEmpty) _syncTextWithModel();
      widget.onChange(_textController.text);
    });
    if (widget.shouldAutofocus) _focusNode.requestFocus();
  }

  @override
  void didUpdateWidget(ManageableListItemTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!_focusNode.hasFocus) _syncTextWithModel();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomStart,
      children: [
        TextField(
          controller: _textController,
          focusNode: _focusNode,
          enableSuggestions: false,
          style: TextStyle(
            color: _focusNode.hasFocus ? null : widget.textColor,
          ),
          decoration: InputDecoration(
            errorText: widget.validity.isValid ? null : widget.validity.message,
            hintText: 'Enter what to do',
          ),
        ),
        if (widget.isPending) const LinearProgressIndicator(),
      ],
    );
  }

  void _syncTextWithModel() {
    _textController.text = widget.label;
  }
}
