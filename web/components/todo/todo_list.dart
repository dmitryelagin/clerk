import 'dart:html';

import 'package:clerk/clerk.dart';

import '../../intl/todo_intl.dart';
import '../../states/todo_list/todo_list_selector.dart';
import '../base/button.dart';
import '../base/div.dart';
import 'todo_item.dart';
import 'todo_list_action.dart';

class TodoListComponent {
  factory TodoListComponent() => _lastInstance;

  TodoListComponent.create(this._evaluator, this._todoList, this._action) {
    _lastInstance = this;
  }

  static TodoListComponent _lastInstance;

  final StoreEvaluator _evaluator;
  final TodoListSelector _todoList;
  final TodoListAction _action;

  Element render() => Div().render(children: [
        for (final id in _evaluator.evaluate(_todoList.getItemsIds))
          TodoItemComponent().render(id),
        if (_evaluator.evaluate(_todoList.isAddingAvailable))
          Button().render(
            TodoIntl.addItem(),
            clickAction: (_) => _action.startItemAdd(),
          ),
      ]);
}
