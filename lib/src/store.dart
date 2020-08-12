import 'context_manager_impl.dart';
import 'interfaces.dart';
import 'state.dart';
import 'store_manager_impl.dart';
import 'store_repository.dart';
import 'store_settings.dart';

/// An object that stores states and provides instruments to manage them.
class Store<S extends Object> {
  /// Creates an assembled [Store].
  factory Store(
    void Function(StoreBuilder) compose,
    StoreSettings<S> settings,
  ) {
    final context = ContextManagerImpl();
    final repository = StoreRepository(context, settings);
    compose(StoreBuilder._(repository));
    final manager = StoreManagerImpl(context, repository);
    return Store._(repository, manager);
  }

  Store._(this._repository, this._manager);

  final StoreRepository<S> _repository;
  final StoreManager _manager;

  /// A [StoreAccessor] instance of this [Store].
  StoreAccessor<S> get accessor => _repository;

  /// A [StoreExecutor] instance of this [Store].
  StoreExecutor get executor => _manager;

  /// A [StoreManager] instance of this [Store].
  StoreManager get manager => _manager;

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
