import 'package:clerk/clerk.dart';
import 'package:demo_core/demo_core.dart';
import 'package:summon/summon.dart';

void initializeTodoModule(Locator locator) {
  final get = locator.get;
  locator
    ..bindSingleton<Store>(
      () => createTodoStore()..executor.apply(get<FetchItems>().call),
      onReset: (store) {
        store.teardown();
      },
    )
    ..bindSingleton(() => TodoLoader())
    ..bindSingleton(() => TodoListReader())
    ..bindSingleton(() => FetchItems(get()))
    ..bindSingleton(() => AddItem(get()))
    ..bindSingleton(() => ChangeItem(get()))
    ..bindSingleton(() => RemoveItem(get()))
    ..bindSingleton(() => const ResetItemValidity())
    ..bindSingleton(() => const StartItemAdd())
    ..bindSingleton(() => ToggleItem(get()))
    ..bindSingleton(() => CommitItem(get(), get(), get()));
}
