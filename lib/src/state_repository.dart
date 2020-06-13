import 'interfaces_private.dart';
import 'interfaces_public.dart';
import 'map_type_utils.dart';
import 'state.dart';
import 'state_aggregate_impl.dart';
import 'state_controller.dart';
import 'state_controller_utils.dart';
import 'state_factory.dart';

class StateRepository {
  StateRepository(this._factory);

  final StateFactory _factory;

  final _accumulatorControllerMap = <Type, StateController>{};
  final _modelControllerMap = <Type, StateController>{};
  final _controllers = <StateController>[];

  StateAggregate get state =>
      StateAggregateImpl(_modelControllerMap.extractModels());

  bool get isEmpty => _controllers.isEmpty;
  bool get hasChanges => _controllers.hasChanges;
  bool get hasDeferredChanges => _controllers.hasDeferredChanges;

  StateManager<Object, A> getByAccumulator<A>() =>
      _accumulatorControllerMap.get(A) ?? _factory.createManager();

  StateManager<M, Object> getByModel<M>() =>
      _modelControllerMap.get(M) ?? _factory.createManager();

  bool has<M>() => _modelControllerMap.containsKey(M);

  void add<M, A>(State<M, A> state) {
    final controller = _factory.createController(state);
    _accumulatorControllerMap[A] = controller;
    _modelControllerMap[M] = controller;
    _controllers.add(controller);
  }

  Future<void> remove<M>() {
    final controller = _modelControllerMap.get<StateController>(M);
    if (controller == null) return Future.value();
    bool isState(Type _, StateController value) => value == controller;
    _accumulatorControllerMap.removeWhere(isState);
    _modelControllerMap.removeWhere(isState);
    _controllers.remove(controller);
    return controller.teardown();
  }

  Future<void> teardown() {
    final teardownState = _controllers.teardown();
    _accumulatorControllerMap.clear();
    _modelControllerMap.clear();
    _controllers.clear();
    return teardownState;
  }

  void endTransanctions() {
    _controllers.endTransanctions();
  }

  void sinkChanges() {
    _controllers.sinkChanges();
  }

  void sinkDeferredChanges() {
    _controllers.sinkDeferredChanges();
  }
}
