import 'package:demo_core/demo_core.dart';
import 'package:flutter_demo/src/module_helpers/module.dart';

Injector initializeTodoModule(Injector injector) => injector
  ..registerFactory((resolve) {
    return createTodoStore()..executor.execute(resolve<Init>()());
  })
  ..registerMimic<TodoListReader, TodoListManager>()
  ..registerSingleton((_) => TodoLoader())
  ..registerSingleton((_) => TodoListManager())
  ..registerSingleton((resolve) => Init(resolve(), resolve()))
  ..registerSingleton((resolve) => AddItem(resolve(), resolve()))
  ..registerSingleton((resolve) => ChangeItem(resolve(), resolve()))
  ..registerSingleton((resolve) => RemoveItem(resolve(), resolve()))
  ..registerSingleton((resolve) => ResetItemValidity(resolve()))
  ..registerSingleton((resolve) => StartItemAdd(resolve()))
  ..registerSingleton((resolve) => ToggleItem(resolve(), resolve()))
  ..registerSingleton((resolve) => CommitItem(resolve(), resolve(), resolve()));
