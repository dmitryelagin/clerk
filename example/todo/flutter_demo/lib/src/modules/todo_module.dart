import 'package:demo_core/demo_core.dart';
import 'package:flutter_demo/src/module_helpers/module.dart';

Injector initializeTodoModule(Injector injector) => injector
  ..mapMimic<TodoListSelector, TodoListManager>()
  ..mapFactory((get) => createTodoStore()..executor.execute(get<Init>()()))
  ..mapSingleton((_) => TodoLoader())
  ..mapSingleton((_) => TodoListManager())
  ..mapSingleton((get) => Init(get(), get()))
  ..mapSingleton((get) => AddItem(get(), get()))
  ..mapSingleton((get) => ChangeItem(get(), get()))
  ..mapSingleton((get) => CommitItemChange(get(), get(), get(), get()))
  ..mapSingleton((get) => RemoveItem(get(), get()))
  ..mapSingleton((get) => StartItemAdd(get()))
  ..mapSingleton((get) => ToggleItem(get(), get()));
