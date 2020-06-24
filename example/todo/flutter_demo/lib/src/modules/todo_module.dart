import 'package:demo_core/demo_core.dart';
import 'package:flutter_demo/src/module_helpers/module.dart';

Injector initializeTodoModule(Injector injector) => injector
  ..registerMimic<TodoListReader, TodoListManager>()
  ..registerFactory((resolve) {
    return createTodoStore()..executor.execute(resolve<Init>()());
  })
  ..registerSingleton((_) => TodoLoader())
  ..registerSingleton((_) => TodoListManager())
  ..registerSingleton((resolve) => Init(resolve(), resolve()))
  ..registerSingleton((resolve) => AddItem(resolve(), resolve()))
  ..registerSingleton((resolve) => ChangeItem(resolve(), resolve()))
  ..registerSingleton((resolve) => RemoveItem(resolve(), resolve()))
  ..registerSingleton((resolve) => StartItemAdd(resolve()))
  ..registerSingleton((resolve) => ToggleItem(resolve(), resolve()))
  ..registerSingleton((resolve) {
    return CommitItemChange(resolve(), resolve(), resolve());
  });
