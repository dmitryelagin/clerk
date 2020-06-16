import 'interfaces_public.dart';
import 'state_factory.dart';
import 'state_repository.dart';
import 'store_accessor_impl.dart';
import 'store_controller.dart';
import 'store_manager_impl.dart';
import 'store_reader_impl.dart';
import 'store_settings.dart';

/// An object that stores states and provides instruments to manage them.
class Store {
  /// Creates an assembled [Store].
  Store([StoreSettings settings = const StoreSettings()]) {
    _factory = StateFactory(settings);
    _repository = StateRepository(settings, _factory);
    _manager = StoreManagerImpl(settings, _repository);
    _accessor = StoreAccessorImpl(_manager, _repository);
    _controller = StoreController(_manager, _repository);
    _reader = StoreReaderImpl(_manager);
  }

  late StateFactory _factory;
  late StateRepository _repository;
  late StoreAccessorImpl _accessor;
  late StoreManagerImpl _manager;
  late StoreController _controller;
  late StoreReaderImpl _reader;

  /// A [StoreAccessor] instance of this store.
  StoreAccessor get accessor => _accessor;

  /// A [StoreComposer] instance of this store.
  StoreComposer get composer => _controller;

  /// A [StoreExecutor] instance of this store.
  StoreExecutor get executor => _controller;

  /// A [StoreReader] instance of this store.
  StoreReader get reader => _reader;

  /// Closes [Store].
  ///
  /// All internal streams will be closed and most internal info will be lost
  /// after calling this method. Use only when you don't need [Store] any more.
  Future<void> teardown() async {
    await Future.wait([
      _manager.teardown(),
      _repository.teardown(),
    ]);
    _factory.clear();
  }
}
