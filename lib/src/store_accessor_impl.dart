import 'dart:async';

import 'action.dart';
import 'interfaces_private.dart';
import 'interfaces_public.dart';
import 'state_repository.dart';

class StoreAccessorImpl implements StoreAccessor {
  StoreAccessorImpl(this._eventBus, this._repository);

  final StoreActionEventBus _eventBus;
  final StateRepository _repository;

  @override
  StateAggregate get state => _repository.state;

  @override
  Stream<StateAggregate> get onChange => _repository.onChange;

  @override
  Stream<StateAggregate> get onAfterChanges => _repository.onAfterChanges;

  @override
  Stream<Action> get onAction => _eventBus.onAction;

  @override
  Stream<M> onModelChange<M>() => _repository.getByModel<M>().onChange;

  @override
  Stream<M> onAfterModelChanges<M>() =>
      _repository.getByModel<M>().onAfterChanges;
}
