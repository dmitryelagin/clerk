import 'dart:async';

import 'action.dart';
import 'interfaces_private.dart';
import 'interfaces_public.dart';
import 'state_repository.dart';
import 'store_settings.dart';

class StoreAccessorImpl
    implements
        StoreAccessor,
        StoreChangeEventBusController,
        StoreActionEventBusController {
  StoreAccessorImpl(StoreSettings settings, this._repository)
      : change = settings.createStreamController(),
        afterChanges = settings.createStreamController(),
        beforeAction = settings.createStreamController(),
        afterAction = settings.createStreamController();

  final StateRepository _repository;

  @override
  final StreamController<StateAggregate> change;

  @override
  final StreamController<StateAggregate> afterChanges;

  @override
  final StreamController<Action> beforeAction;

  @override
  final StreamController<Action> afterAction;

  @override
  Stream<StateAggregate> get onChange => change.stream;

  @override
  Stream<StateAggregate> get onAfterChanges => afterChanges.stream;

  @override
  Stream<Action> get onBeforeAction => beforeAction.stream;

  @override
  Stream<Action> get onAfterAction => afterAction.stream;

  @override
  StateAggregate get state => _repository.state;

  @override
  Stream<M> onModelChange<M>() => _repository.getByModel<M>().onChange;

  @override
  Stream<M> onAfterModelChanges<M>() =>
      _repository.getByModel<M>().onAfterChanges;

  Future<void> teardown() async {
    await Future.wait<void>([
      change.close(),
      afterChanges.close(),
      beforeAction.close(),
      afterAction.close(),
    ]);
  }
}
