import 'dart:async';

import 'action.dart';
import 'interfaces_public.dart';
import 'state_repository.dart';
import 'store_event_bus_controller.dart';

class StoreAccessorImpl implements StoreAccessor {
  const StoreAccessorImpl(this._eventBus, this._repository);

  final StoreEventBusController _eventBus;
  final StateRepository _repository;

  @override
  StateAggregate get state => _repository.state;

  @override
  Stream<StateAggregate> get onChange => _eventBus.change.stream;

  @override
  Stream<StateAggregate> get onAfterChanges => _eventBus.afterChanges.stream;

  @override
  Stream<Action> get onBeforeAction => _eventBus.beforeAction.stream;

  @override
  Stream<Action> get onAfterAction => _eventBus.afterAction.stream;

  @override
  Stream<Type> get onEvaluationFailed => _eventBus.evaluationFailed.stream;

  @override
  Stream<Type> get onAssignmentFailed => _eventBus.assignmentFailed.stream;

  @override
  Stream<Type> get onListenChangeFailed => _eventBus.listenChangeFailed.stream;

  @override
  Stream<Type> get onListenAfterChangesFailed =>
      _eventBus.listenAfterChangesFailed.stream;

  @override
  Stream<M> onModelChange<M>() => _repository.getByModel<M>().onChange;

  @override
  Stream<M> onAfterModelChanges<M>() =>
      _repository.getByModel<M>().onAfterChanges;
}
