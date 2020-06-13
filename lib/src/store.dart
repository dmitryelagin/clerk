import 'interfaces_public.dart';
import 'state_factory.dart';
import 'state_repository.dart';
import 'store_accessor_impl.dart';
import 'store_composer_impl.dart';
import 'store_evaluator_impl.dart';
import 'store_executor_impl.dart';
import 'store_manager_impl.dart';
import 'store_settings.dart';

/// An object that stores states and provides instruments to manage them.
class Store {
  /// Creates an assembled [Store].
  Store([StoreSettings settings = const StoreSettings()]) {
    _factory = StateFactory(settings);
    _repository = StateRepository(_factory);
    _accessor = StoreAccessorImpl(settings, _repository);
    _composer = StoreComposerImpl(_accessor, _repository);
    _manager = StoreManagerImpl(_accessor, _repository);
    _executor = StoreExecutorImpl(_composer, _manager);
    _evaluator = StoreEvaluatorImpl(_manager);
  }

  StateFactory _factory;
  StateRepository _repository;
  StoreAccessorImpl _accessor;
  StoreComposerImpl _composer;
  StoreManagerImpl _manager;
  StoreExecutorImpl _executor;
  StoreEvaluatorImpl _evaluator;

  /// A [StoreAccessor] instance of this store.
  StoreAccessor get accessor => _accessor;

  /// A [StoreComposer] instance of this store.
  StoreComposer get composer => _composer;

  /// A [StoreExecutor] instance of this store.
  StoreExecutor get executor => _executor;

  /// A [StoreEvaluator] instance of this store.
  StoreEvaluator get evaluator => _evaluator;

  /// Closes [Store].
  ///
  /// All internal streams will be closed and most internal info will be lost
  /// after calling this method. Use only when you don't need [Store] any more.
  Future<void> teardown() async {
    _factory.clear();
    await Future.wait([
      _accessor.teardown(),
      _repository.teardown(),
    ]);
  }
}
