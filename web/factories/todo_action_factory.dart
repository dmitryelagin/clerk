import '../actions/add_item.dart';
import '../actions/commit_item_change.dart';
import '../actions/init.dart';
import '../actions/remove_item.dart';
import '../actions/start_item_add.dart';
import '../actions/start_item_change.dart';
import '../actions/stop_item_change.dart';
import '../actions/toggle_item.dart';
import '../components/todo/todo_item_action.dart';
import '../components/todo/todo_list_action.dart';
import '../services/todo_loader.dart';
import '../states/todo_list/todo_list_state.dart';

class TodoActionFactory
    with
        Init,
        AddItem,
        RemoveItem,
        ToggleItem,
        StartItemAdd,
        StartItemChange,
        StopItemChange,
        CommitItemChange
    implements TodoItemAction, TodoListAction {
  TodoActionFactory(this.loader, this.todoList);

  @override
  final TodoLoader loader;

  @override
  final TodoListManager todoList;
}
