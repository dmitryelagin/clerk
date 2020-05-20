import 'dart:html';

import 'package:clerk/clerk.dart';

import '../../intl/todo_intl.dart';
import '../../models/todo_item_id.dart';
import '../../states/todo_list/todo_list_selector_factory.dart';
import '../base/button.dart';
import '../base/checkbox.dart';
import '../base/div.dart';
import '../base/input.dart';
import '../base/span.dart';
import 'todo_item_action.dart';

class TodoItemComponent {
  factory TodoItemComponent() => _lastInstance;

  TodoItemComponent.create(this._evaluate, this._todoList, this._action) {
    _lastInstance = this;
  }

  static TodoItemComponent _lastInstance;

  final Evaluate _evaluate;
  final TodoListSelectorFactory _todoList;
  final TodoItemAction _action;

  Element render(TodoItemId id) {
    final item = _evaluate(_todoList.getItem(id));
    final isChanging = _evaluate(_todoList.isChangingItem(id));
    return Div().render(children: [
      Checkbox().render(
        isChecked: item.isDone,
        toggleAction: (_) => _action.toggleItem(id),
      ),
      if (isChanging)
        Input().render(
          item.label,
          isAutofocused: true,
          blurAction: (_, value) => _action.commitItemChange(id, value),
          keyDownAction: (event, value) =>
              _action.commitItemChange(id, value, event.keyCode),
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
