import 'package:clerk/clerk.dart';
import 'package:demo_core/demo_core.dart';
import 'package:summon/summon.dart';

void initializeTodoModule(Locator locator) {
  final get = locator.get;
  locator
    ..bindSingleton<Store>(
      () => createTodoStore()..executor.execute(get<Init>()()),
      onReset: (store) {
        store.teardown();
      },
    )
    ..bindSingleton<TodoListReader>(
      () => get<TodoListManager>(), // ignore: unnecessary_lambdas
    )
    ..bindSingleton(() => TodoLoader())
    ..bindSingleton(() => TodoListManager())
    ..bindSingleton(() => Init(get(), get()))
    ..bindSingleton(() => AddItem(get(), get()))
    ..bindSingleton(() => ChangeItem(get(), get()))
    ..bindSingleton(() => RemoveItem(get(), get()))
    ..bindSingleton(() => ResetItemValidity(get()))
    ..bindSingleton(() => StartItemAdd(get()))
    ..bindSingleton(() => ToggleItem(get(), get()))
    ..bindSingleton(() => CommitItem(get(), get(), get()));
}
