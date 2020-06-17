import 'interfaces_public.dart';
import 'state.dart';
import 'state_factory.dart';
import 'state_repository.dart';
import 'store_accessor_impl.dart';
import 'store_executor_impl.dart';
import 'store_manager_impl.dart';
import 'store_reader_impl.dart';
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
    return Store._(builder._repository, settings);
  }

  Store._(this._repository, StoreSettings settings)
      : _manager = StoreManagerImpl(settings, _repository) {
    _accessor = StoreAccessorImpl(_manager, _repository);
    _executor = StoreExecutorImpl(_manager, _repository);
    _reader = StoreReaderImpl(_manager);
  }

  final StateRepository _repository;
  final StoreManagerImpl _manager;

  StoreAccessorImpl _accessor;
  StoreExecutorImpl _executor;
  StoreReaderImpl _reader;

  /// A [StoreAccessor] instance of this [Store].
  StoreAccessor get accessor => _accessor;

  /// A [StoreExecutor] instance of this [Store].
  StoreExecutor get executor => _executor;

  /// A [StoreReader] instance of this [Store].
  StoreReader get reader => _reader;

  /// Closes [Store].
  ///
  /// All internal streams will be closed and some internal info may be lost
  /// after calling this method. Use only when you don't need [Store] any more.
  Future<void> teardown() async {
    await Future.wait([
      _manager.teardown(),
      _repository.teardown(),
    ]);
  }
}

/// An object that can assemble [State]s.
class StoreBuilder {
  StoreBuilder._(StoreSettings settings)
      : _repository = StateRepository(settings, StateFactory(settings));

  final StateRepository _repository;

  /// Adds [State] to [StoreBuilder].
  void add<M, A>(State<M, A> state) {
    _repository.add(state);
  }
}
