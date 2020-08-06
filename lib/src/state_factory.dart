import 'interfaces.dart';
import 'state.dart';
import 'state_aggregate_impl.dart';
import 'state_controller.dart';
import 'state_manager_null.dart';
import 'store_settings.dart';

class StateFactory {
  StateFactory(this._settings, this._context);

  final StoreSettings _settings;
  final ContextManager _context;

  final _cache = <Type, StateManager>{};

  StateManager<M, A> getManager<M, A>() {
    final manager = _cache[M];
    if (manager != null && manager is StateManager<M, A>) return manager;
    return _cache[M] = StateManagerNull<M, A>(_settings);
  }

  StateController<M, A> getController<M, A>(State<M, A> state) =>
      StateController(state, _settings, _context);

  StateAggregate getAggregate(Map<Type, Object> models) =>
      StateAggregateImpl(models);
}
