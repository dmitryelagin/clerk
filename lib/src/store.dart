import 'interfaces_public.dart';
import 'state.dart';
import 'state_factory.dart';
import 'store_manager_impl.dart';
import 'store_repository.dart';
import 'store_settings.dart';
import 'types_public.dart';

/// An object that stores states and provides instruments to manage them.
class Store {
  /// Creates an assembled [Store].
  factory Store(
    Compose compose, {
    StoreSettings settings = const StoreSettings(),
  }) {
    final builder = StoreBuilder._(settings);
    compose(builder);
    return Store._(builder._repository);
  }

  Store._(this._repository) : _manager = StoreManagerImpl(_repository);

  final StoreManagerImpl _manager;
  final StoreRepository _repository;

  /// A [StoreAccessor] instance of this [Store].
  StoreAccessor get accessor => _repository;

  /// A [StoreExecutor] instance of this [Store].
  StoreExecutor get executor => _manager;

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
  StoreBuilder._(StoreSettings settings)
      : _repository = StoreRepository(settings, StateFactory(settings));

  final StoreRepository _repository;

  /// Adds [State] to [StoreBuilder].
  void add<M, A>(State<M, A> state) {
    _repository.add(state);
  }
}
