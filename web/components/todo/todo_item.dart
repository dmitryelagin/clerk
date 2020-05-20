import 'dart:html';

import 'package:clerk/clerk.dart';

import '../../intl/todo_intl.dart';
import '../../models/todo_item_id.dart';
import '../../states/todo_list/todo_list_selector.dart';
import '../base/button.dart';
import '../base/checkbox.dart';
import '../base/div.dart';
import '../base/input.dart';
import '../base/span.dart';
import 'todo_item_action.dart';

class TodoItemComponent {
  factory TodoItemComponent() => _lastInstance;

  TodoItemComponent.create(this._evaluator, this._todoList, this._action) {
    _lastInstance = this;
  }

  static TodoItemComponent _lastInstance;

  final StoreEvaluator _evaluator;
  final TodoListSelector _todoList;
  final TodoItemAction _action;

  Element render(TodoItemId id) {
    final item = _evaluator.evaluateUnary(_todoList.getItem, id);
    final isChanging = _evaluator.evaluateUnary(_todoList.isChangingItem, id);
    return Div().render(children: [
      Checkbox().render(
        isChecked: item.isChecked,
        toggleAction: (_) => _action.toggleItem(id),
      ),
      if (isChanging)
        Input().render(
          item.label,
          isAutofocused: true,
          keyDownAction: (event, value) {
            switch (event.keyCode) {
              case KeyCode.ESC:
                return _action.stopItemChange();
              case KeyCode.ENTER:
                return _action.changeItem(id, value);
              default:
                return null;
            }
          },
        ),
      if (!isChanging)
        Span().render(
          item.label,
          clickAction: (_) => _action.startItemChange(id),
        ),
      Button().render(
        TodoIntl.removeItem(),
        clickAction: (_) => _action.removeItem(id),
      ),
    ]);
  }
}