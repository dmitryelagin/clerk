import 'dart:async';

import 'action.dart';
import 'change_manager_repository.dart';
import 'private_interfaces.dart';
import 'public_interfaces.dart';
import 'state_aggregate_impl.dart';
import 'state_repository.dart';

class StoreAccessorImpl implements StoreAccessor, StoreEventBusController {
  StoreAccessorImpl(this._repository, this._changesRepository);

  static StreamController<T> _createController<T>() =>
      StreamController.broadcast(sync: true);

  @override
  final StreamController<Action> beforeAction = _createController();

  @override
  final StreamController<Action> afterAction = _createController();

  @override
  final StreamController<Type> evaluationFailed = _createController();

  @override
  final StreamController<Type> assignmentFailed = _createController();

  final _change = _createController<StateAggregate>();
  final _afterChanges = _createController<StateAggregate>();
  final _zone = Zone.current;

  final StateRepository _repository;
  final ChangeManagerRepository _changesRepository;

  var _state = StateAggregateImpl.empty;
  var _hasScheduledChanges = false;

  @override
  StateAggregate get state => _state;

  @override
  Stream<Action> get onBeforeAction => beforeAction.stream;

  @override
  Stream<Action> get onAfterAction => afterAction.stream;

  @override
  Stream<Type> get onEvaluationFailed => evaluationFailed.stream;

  @override
  Stream<Type> get onAssignmentFailed => assignmentFailed.stream;

  @override
  Stream<StateAggregate> get onChange => _change.stream;

  @override
  Stream<StateAggregate> get onAfterChanges => _afterChanges.stream;

  @override
  Stream<M> onModelChange<M>() => _changesRepository.get<M>()?.onModelChange;

  @override
  Stream<M> onAfterModelChanges<M>() =>
      _changesRepository.get<M>()?.onAfterModelChanges;

  @override
  void connect<M>(Stream<M> changes) {
    _zone.run(() {
      _changesRepository.add(changes);
    });
  }

  @override
  void disconnect<M>() {
    _changesRepository.remove<M>();
  }

  @override
  void endTransanction() {
    _state = StateAggregateImpl(_repository.models);
    if (_changesRepository.hasChanges) {
      _changesRepository.sinkChanges();
      _change.add(_state);
    }
    if (!_hasScheduledChanges && _changesRepository.hasDeferredChanges) {
      _hasScheduledChanges = true;
      _zone.scheduleMicrotask(() {
        _changesRepository.sinkDeferredChanges();
        _afterChanges.add(_state);
        _hasScheduledChanges = false;
      });
    }
  }

  void teardown() {
    beforeAction.close();
    afterAction.close();
    evaluationFailed.close();
    assignmentFailed.close();
    _change.close();
    _afterChanges.close();
  }
}
