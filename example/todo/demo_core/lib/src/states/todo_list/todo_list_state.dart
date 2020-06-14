import 'package:clerk/clerk.dart';

import 'todo_list_accumulator.dart';
import 'todo_list_model.dart';
import 'todo_list_model_utils.dart';
import 'todo_list_reader.dart';
import 'todo_list_writer.dart';

class TodoListManager = TodoListReader with TodoListWriter;

State<TodoListModel, TodoListAccumulator> createTodoListState() {
  return State(
    TodoListAccumulator(),
    (accumulator) => TodoListModel.fromAccumulator(accumulator),
    (model) => TodoListAccumulator.fromModel(model),
    (a, b) => a.equals(b),
  );
}
