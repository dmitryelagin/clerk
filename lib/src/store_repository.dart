import 'dart:async';

import 'interfaces.dart';
import 'map_utils.dart';
import 'state.dart';
import 'state_aggregate_impl.dart';
import 'state_controller.dart';
import 'state_controller_utils.dart';
import 'state_factory.dart';
import 'store_settings.dart';

class StoreRepository implements StoreAccessor {
  StoreRepository(StoreSettings settings, this._factory)
      : _change = settings.getStreamController(),
        _afterChanges = settings.getStreamController();

  final StateFactory _factory;
  final StreamController<StateAggregate> _change;
  final StreamController<StateAggregate> _afterChanges;

  final _accumulatorControllerMap = <Type, StateController>{};
  final _modelControllerMap = <Type, StateController>{};
  final _controllers = <StateController>[];

  final _zone = Zone.current;

  var _hasScheduledChangesSink = false;

  bool get isTeardowned => _change.isClosed;

  @override
  StateAggregate get state =>
      StateAggregateImpl(_modelControllerMap.extractModels());

  @override
  Stream<StateAggregate> get onChange => _change.stream;

  @override
  Stream<StateAggregate> get onAfterChanges => _afterChanges.stream;

  @override
  Stream<M> onModelChange<M>() => getByModel<M>().onChange;

  @override
  Stream<M> onAfterModelChanges<M>() => getByModel<M>().onAfterChanges;

  StateManager<Object, A> getByAccumulator<A>() =>
      _accumulatorControllerMap.get(A) ?? _factory.getManager();

  StateManager<M, Object> getByModel<M>() =>
      _modelControllerMap.get(M) ?? _factory.getManager();

  bool hasModel<M>() => _modelControllerMap.containsKey(M);
  bool hasAccumulator<A>() => _accumulatorControllerMap.containsKey(A);

  void add<M, A>(State<M, A> state) {
    final controller = _factory.getController(state);
    _accumulatorControllerMap[A] = controller;
    _modelControllerMap[M] = controller;
    _controllers.add(controller);
  }

  void applyChanges() {
    _controllers.checkChanges();
    if (_controllers.hasChanges) _sinkChanges();
    if (!_hasScheduledChangesSink && _controllers.hasDeferredChanges) {
      _hasScheduledChangesSink = true;
      _zone.scheduleMicrotask(_sinkDeferredChanges);
    }
  }

  Future<void> teardown() async {
    await Future.wait([
      _change.close(),
      _afterChanges.close(),
      _controllers.teardown(),
    ]);
  }

  void _sinkChanges() {
    _controllers.sinkChanges();
    _change.add(state);
  }

  void _sinkDeferredChanges() {
    _controllers.sinkDeferredChanges();
    _afterChanges.add(state);
    _hasScheduledChangesSink = false;
  }
}
