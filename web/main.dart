import 'dart:html';

import 'package:clerk/clerk.dart';

import 'components/base/button.dart';
import 'components/base/checkbox.dart';
import 'components/base/div.dart';
import 'components/base/input.dart';
import 'components/base/span.dart';
import 'components/todo/todo_item.dart';
import 'components/todo/todo_list.dart';
import 'factories/todo_action_factory.dart';
import 'factories/todo_store_factory.dart';
import 'services/todo_loader.dart';
import 'states/todo_list/todo_list_selector_factory.dart';
import 'states/todo_list/todo_list_state.dart';

void main() {
  final store = createTodoStore();
  final manager = TodoListManager();
  final action = TodoActionFactory(TodoLoader(), manager);
  _initializeComponents(store, manager, action);
  final appRoot = document.querySelector('#app')
    ..append(TodoListComponent().render());
  store.accessor.onChange.listen((_) {
    appRoot
      ..children.clear()
      ..append(TodoListComponent().render());
  });
  store.executor.execute(action.init());
}

void _initializeComponents(
  Store store,
  TodoListSelectorFactory selector,
  TodoActionFactory action,
) {
  Div.create();
  Button.create(store.executor.execute);
  Checkbox.create(store.executor.execute);
  Input.create(store.executor.execute);
  Span.create(store.executor.execute);
  TodoItemComponent.create(store.evaluator.evaluate, selector, action);
  TodoListComponent.create(store.evaluator.evaluate, selector, action);
}
