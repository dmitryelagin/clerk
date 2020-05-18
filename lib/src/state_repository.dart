import 'map_utils.dart';
import 'state_manager.dart';

class StateRepository {
  static MapEntry<Type, Object> _getTypeModel(Type type, StateManager state) =>
      MapEntry(type, state.model);

  final _accumulatorStateMap = <Type, StateManager>{};
  final _modelStateMap = <Type, StateManager>{};
  final _states = <StateManager>[];

  bool get isEmpty => _states.isEmpty;
  Iterable<StateManager> get values => _states;
  Map<Type, Object> get models => _modelStateMap.map(_getTypeModel);

  StateManager<Object, A> getByAccumulator<A>() => _accumulatorStateMap.get(A);
  StateManager<M, Object> getByModel<M>() => _modelStateMap.get(M);

  StateManager<M, A> add<M, A>(StateManager<M, A> state) {
    _accumulatorStateMap[A] = state;
    _modelStateMap[M] = state;
    _states.add(state);
    return state;
  }

  StateManager<M, Object> remove<M>() {
    final state = getByModel<M>();
    if (state == null) return null;
    bool isState(Type _, StateManager value) => value == state;
    _accumulatorStateMap.removeWhere(isState);
    _modelStateMap.removeWhere(isState);
    _states.remove(state);
    return state;
  }

  void clear() {
    for (final state in _states) {
      state.teardown();
    }
    _accumulatorStateMap.clear();
    _modelStateMap.clear();
    _states.clear();
  }
}
