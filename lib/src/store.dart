import 'change_manager_repository.dart';
import 'public_interfaces.dart';
import 'state_repository.dart';
import 'store_accessor_impl.dart';
import 'store_composer_impl.dart';
import 'store_evaluator_impl.dart';
import 'store_executor_impl.dart';
import 'store_manager_impl.dart';

/// An object that stores states and provides instruments to manage them.
class Store {
  /// Creates an assembled [Store].
  Store() {
    _accessor = StoreAccessorImpl(_repository, _changesRepository);
    _manager = StoreManagerImpl(_repository, _accessor);
    _composer = StoreComposerImpl(_repository, _accessor);
    _executor = StoreExecutorImpl(_composer, _manager);
    _evaluator = StoreEvaluatorImpl(_manager);
  }

  final _repository = StateRepository();
  final _changesRepository = ChangeManagerRepository();

  StoreAccessorImpl _accessor;
  StoreManagerImpl _manager;
  StoreComposerImpl _composer;
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
  void teardown() {
    _composer.teardown();
    _accessor.teardown();
    _repository.clear();
    _changesRepository.clear();
  }
}
