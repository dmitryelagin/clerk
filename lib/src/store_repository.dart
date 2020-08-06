import 'dart:async';

import 'interfaces.dart';
import 'map_utils.dart';
import 'state.dart';
import 'state_controller.dart';
import 'state_factory.dart';
import 'store_settings.dart';

class StoreRepository implements StoreAccessor {
  StoreRepository(StoreSettings settings, this._factory, this._context)
      : _change = settings.getStreamController();

  final StateFactory _factory;
  final ContextManager _context;
  final StreamController<StateAggregate> _change;

  final _accumulatorControllerMap = <Type, StateController>{};
  final _modelControllerMap = <Type, StateController>{};
  final _controllers = <StateController>[];

  @override
  StateAggregate get state {
    return _factory.getAggregate({
      for (final key in _modelControllerMap.keys)
        key: _modelControllerMap[key].model,
    });
  }

  @override
  Stream<StateAggregate> get onChange => _change.stream;

  @override
  Stream<M> onModelChange<M>() => getByModel<M>().onChange;

  bool hasAccumulator<A>() => _accumulatorControllerMap.containsKey(A);
  bool hasModel<M>() => _modelControllerMap.containsKey(M);

  StateManager<Object, A> getByAccumulator<A>() =>
      _accumulatorControllerMap.get(A) ?? _factory.getManager();

  StateManager<M, Object> getByModel<M>() =>
      _modelControllerMap.get(M) ?? _factory.getManager();

  void add<M, A>(State<M, A> state) {
    final controller = _factory.getController(state);
    _accumulatorControllerMap[A] = controller;
    _modelControllerMap[M] = controller;
    _controllers.add(controller);
  }

  void applyChanges() {
    for (final controller in _controllers) {
      controller.sinkChange();
    }
    if (_change.hasListener && _context.hasPossibleChanges) {
      _change.add(state);
    }
  }

  Future<void> teardown() {
    return Future.wait([
      _change.close(),
      ..._controllers.map((controller) => controller.teardown()),
    ]);
  }
}
