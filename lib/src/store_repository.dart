import 'dart:async';

import 'context_manager.dart';
import 'interfaces.dart';
import 'state.dart';
import 'state_controller.dart';
import 'store_settings.dart';

class StoreRepository<S extends Object?> implements StoreAccessor<S> {
  StoreRepository(this._context, this._settings)
      : _change = _settings.getStreamController();

  final ContextManager _context;
  final StoreSettings<S> _settings;
  final StreamController<S> _change;

  final _accumulatorControllerMap = <Type, StateController>{};
  final _modelControllerMap = <Type, StateController>{};
  final _controllers = <StateController>[];

  static T? _getTypedValue<T>(Object? value) => value is T ? value : null;

  @override
  S get state => _settings.getStateAggregate(_getModels);

  @override
  Stream<S> get onChange => _change.stream;

  @override
  Stream<M> onModelChange<M>() =>
      _getTypedValue(_modelControllerMap[M]?.onChange) ??
      _settings.getModelChangeFallback();

  M getModel<M>() =>
      _getTypedValue(_modelControllerMap[M]?.model) ??
      _settings.getModelFallback();

  A getAccumulator<A>() =>
      _getTypedValue(_accumulatorControllerMap[A]?.accumulator) ??
      _settings.getAccumulatorFallback();

  void add<M, A>(State<M, A> state) {
    final controller = StateController(state, _context, _settings);
    _accumulatorControllerMap[A] = controller;
    _modelControllerMap[M] = controller;
    _controllers.add(controller);
  }

  void applyChanges() {
    if (!_context.hasPossibleChanges) return;
    var hasChange = false;
    for (final controller in _controllers) {
      hasChange = controller.trySinkChange() || hasChange;
    }
    if (hasChange && _change.hasListener) _change.add(state);
  }

  Future<void> teardown() {
    return Future.wait([
      _change.close(),
      ..._controllers.map((controller) => controller.teardown()),
    ]);
  }

  Map<Type, Object?> _getModels() => {
        for (final key in _modelControllerMap.keys)
          key: _modelControllerMap[key]!.model,
      };
}
