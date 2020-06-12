import 'interfaces_private.dart';
import 'state.dart';
import 'state_controller.dart';
import 'state_manager_null.dart';

class StateFactory {
  StateFactory(this._eventBus);

  final StoreFailureEventBusController _eventBus;

  final _cache = <Type, StateManager>{};

  StateManager<M, A> createManager<M, A>() {
    final manager = _cache[M];
    if (manager != null && manager is StateManager<M, A>) return manager;
    return _cache[M] = StateManagerNull<M, A>(_eventBus);
  }

  StateController<M, A> createController<M, A>(State<M, A> state) {
    _cache.remove(M);
    return StateController(
      state.initial,
      state.getAccumulator,
      state.getModel,
      state.areEqualModels,
    );
  }

  void clear() {
    _cache.clear();
  }
}
