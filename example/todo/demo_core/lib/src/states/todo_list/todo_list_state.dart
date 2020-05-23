import 'package:clerk/clerk.dart';

import 'todo_list_accumulator.dart';
import 'todo_list_model.dart';
import 'todo_list_model_utils.dart';
import 'todo_list_selector_factory.dart';
import 'todo_list_writer_factory.dart';

class TodoListManager = TodoListSelectorFactory with TodoListWriterFactory;

State<TodoListModel, TodoListAccumulator> createTodoListState() => State(
      (model) => model != null
          ? TodoListAccumulator.fromModel(model)
          : TodoListAccumulator(),
      (accumulator) => TodoListModel.fromAccumulator(accumulator),
      (a, b) => a.equals(b),
    );
