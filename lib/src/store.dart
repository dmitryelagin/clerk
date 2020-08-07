import 'context_manager_impl.dart';
import 'interfaces.dart';
import 'state.dart';
import 'state_factory.dart';
import 'store_executor_impl.dart';
import 'store_manager_impl.dart';
import 'store_repository.dart';
import 'store_settings.dart';

/// An object that stores states and provides instruments to manage them.
class Store {
  /// Creates an assembled [Store].
  factory Store(
    void Function(StoreBuilder) compose, {
    StoreSettings settings = const StoreSettings(),
  }) {
    final context = ContextManagerImpl();
    final repository =
        StoreRepository(settings, StateFactory(settings, context));
    compose(StoreBuilder._(repository));
    return Store._(repository, context);
  }

  Store._(this._repository, ExecutionHelper helper)
      : _manager = StoreManagerImpl(_repository) {
    _executor = StoreExecutorImpl(_repository, _manager, helper);
  }

  final StoreManagerImpl _manager;
  final StoreRepository _repository;

  late StoreExecutorImpl _executor;

  /// A [StoreAccessor] instance of this [Store].
  StoreAccessor get accessor => _repository;

  /// A [StoreExecutor] instance of this [Store].
  StoreExecutor get executor => _executor;

  /// A [StoreReader] instance of this [Store].
  StoreReader get reader => _manager;

  /// Closes [Store].
  ///
  /// All internal streams will be closed and some internal info may be lost
  /// after calling this method. Use only when you don't need [Store] any more.
  Future<void> teardown() => _repository.teardown();
}

/// An object that can assemble [State]s.
class StoreBuilder {
  StoreBuilder._(this._repository);

  final StoreRepository _repository;

  /// Adds [State] to [StoreBuilder].
  void add<M, A>(State<M, A> state) {
    _repository.add(state);
  }
}
