import 'package:clerk/clerk.dart';
import 'package:demo_core/demo_core.dart';
import 'package:flutter_demo/src/module_helpers/index.dart';

void initializeTodoModule(Locator locator) {
  final resolve = locator.resolve;
  locator
    ..registerSingleton<Store>(
      () => createTodoStore()..executor.execute(resolve<Init>()()),
      onReset: (store) {
        store.teardown();
      },
    )
    ..registerSingleton<TodoListReader>(
      () => resolve<TodoListManager>(), // ignore: unnecessary_lambdas
    )
    ..registerSingleton(() => TodoLoader())
    ..registerSingleton(() => TodoListManager())
    ..registerSingleton(() => Init(resolve(), resolve()))
    ..registerSingleton(() => AddItem(resolve(), resolve()))
    ..registerSingleton(() => ChangeItem(resolve(), resolve()))
    ..registerSingleton(() => RemoveItem(resolve(), resolve()))
    ..registerSingleton(() => ResetItemValidity(resolve()))
    ..registerSingleton(() => StartItemAdd(resolve()))
    ..registerSingleton(() => ToggleItem(resolve(), resolve()))
    ..registerSingleton(() => CommitItem(resolve(), resolve(), resolve()));
}
