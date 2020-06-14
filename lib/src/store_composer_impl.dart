import 'dart:async';

import 'interfaces_private.dart';
import 'interfaces_public.dart';
import 'state.dart';
import 'state_repository.dart';

class StoreComposerImpl implements StoreComposer, StoreController {
  StoreComposerImpl(this._eventBus, this._repository);

  final StoreChangeEventBusController _eventBus;
  final StateRepository _repository;

  final _zone = Zone.current;

  var _hasTransanction = false;
  var _hasScheduledChangesSink = false;

  @override
  bool get isTeardowned => _eventBus.change.isClosed;

  @override
  bool get canNotStartTransanction => _hasTransanction || isTeardowned;

  @override
  void add<M, A>(State<M, A> state) {
    if (canNotStartTransanction) return;
    _repository.add(state);
    _notifyListeners();
  }

  @override
  Future<void> remove<M>() {
    if (canNotStartTransanction || !_repository.has<M>()) {
      return Future.value();
    }
    final teardownState = _repository.remove<M>();
    _notifyListeners();
    return teardownState;
  }

  @override
  void beginTransanction() {
    _hasTransanction = true;
  }

  @override
  void endTransanction() {
    if (!_hasTransanction) return;
    _repository.endTransanctions();
    _notifyListeners();
    _hasTransanction = false;
  }

  void _notifyListeners() {
    if (_repository.hasChanges) {
      _repository.sinkChanges();
      _eventBus.change.add(_repository.state);
    }
    if (!_hasScheduledChangesSink && _repository.hasDeferredChanges) {
      _hasScheduledChangesSink = true;
      _zone.scheduleMicrotask(() {
        _repository.sinkDeferredChanges();
        _eventBus.afterChanges.add(_repository.state);
        _hasScheduledChangesSink = false;
      });
    }
  }
}
