import 'package:clerk/clerk.dart';

import 'todo_list.dart';
import 'todo_list_model.dart';
import 'todo_list_model_utils.dart';

class TodoListState implements State<TodoListModel, TodoList> {
  @override
  TodoList get accumulator => TodoList();

  @override
  TodoListModel getModel(TodoList accumulator) =>
      TodoListModel.fromAccumulator(accumulator);

  @override
  bool areEqualModels(TodoListModel a, TodoListModel b) => a.equals(b);
}
