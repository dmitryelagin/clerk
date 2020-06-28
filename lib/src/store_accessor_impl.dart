import 'dart:async';

import 'interfaces_public.dart';
import 'state_repository.dart';

class StoreAccessorImpl implements StoreAccessor {
  const StoreAccessorImpl(this._repository);

  final StateRepository _repository;

  @override
  StateAggregate get state => _repository.state;

  @override
  Stream<StateAggregate> get onChange => _repository.onChange;

  @override
  Stream<StateAggregate> get onAfterChanges => _repository.onAfterChanges;

  @override
  Stream<M> onModelChange<M>() => _repository.getByModel<M>().onChange;

  @override
  Stream<M> onAfterModelChanges<M>() =>
      _repository.getByModel<M>().onAfterChanges;
}
