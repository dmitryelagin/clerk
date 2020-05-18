import 'private_interfaces.dart';
import 'public_interfaces.dart';
import 'state.dart';
import 'state_manager.dart';
import 'state_repository.dart';

class StoreComposerImpl implements StoreComposer, StoreController {
  StoreComposerImpl(this._repository, this._eventBus);

  final StateRepository _repository;
  final StoreChangeEventBusController _eventBus;

  var _isTeardowned = false;
  var _hasTransanction = false;

  @override
  bool get isTeardowned => _isTeardowned;

  @override
  bool get hasTransanction => _hasTransanction;

  @override
  void add<M, A>(State<M, A> state) {
    if (_hasTransanction || _isTeardowned) return;
    final manager = StateManager.fromState(state);
    _repository.add(manager);
    _eventBus
      ..connect(manager.onChange)
      ..endTransanction();
  }

  @override
  void remove<M>() {
    if (_hasTransanction || _isTeardowned) return;
    final manager = _repository.remove<M>();
    if (manager == null) return;
    manager.teardown();
    _eventBus
      ..disconnect<M>()
      ..endTransanction();
  }

  @override
  void beginTransanction() {
    _hasTransanction = true;
  }

  @override
  void endTransanction() {
    if (!_hasTransanction) return;
    for (final manager in _repository.values) {
      manager.endTransanction();
    }
    _eventBus.endTransanction();
    _hasTransanction = false;
  }

  void teardown() {
    _isTeardowned = true;
  }
}
