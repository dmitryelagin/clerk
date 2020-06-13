import 'interfaces_private.dart';
import 'state.dart';
import 'state_controller.dart';
import 'state_manager_null.dart';
import 'store_settings.dart';

class StateFactory {
  StateFactory(this._settings);

  final StoreSettings _settings;

  final _cache = <Type, StateManager>{};

  StateManager<M, A> createManager<M, A>() {
    final manager = _cache[M];
    if (manager != null && manager is StateManager<M, A>) return manager;
    return _cache[M] = StateManagerNull<M, A>(_settings);
  }

  StateController<M, A> createController<M, A>(State<M, A> state) {
    _cache.remove(M);
    return StateController(
      _settings,
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
