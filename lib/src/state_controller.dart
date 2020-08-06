import 'dart:async';

import 'interfaces.dart';
import 'state.dart';
import 'store_settings.dart';
import 'types.dart';

class StateController<M extends Object, A extends Object>
    implements StateManager<M, A> {
  StateController(State<M, A> state, StoreSettings settings, this._context)
      : _accumulator = state.accumulator,
        _getModel = state.getModel,
        _areEqualModels = state.areEqualModels,
        _change = settings.getStreamController() {
    _model = state.getModel(_accumulator);
  }

  final A _accumulator;
  final ContextManager _context;
  final GetModel<M, A> _getModel;
  final CompareModels<M> _areEqualModels;
  final StreamController<M> _change;

  M _model;

  @override
  Stream<M> get onChange => _change.stream.distinct(_areEqualModels);

  M get model => _prepareModel();

  bool get _hasPossibleChange => _context.hasPossibleChange(A);

  @override
  V read<V>(Read<M, V> fn) => fn(_prepareModel());

  @override
  V readUnary<V, X>(ReadUnary<M, V, X> fn, X x) => fn(_prepareModel(), x);

  @override
  V readBinary<V, X, Y>(ReadBinary<M, V, X, Y> fn, X x, Y y) =>
      fn(_prepareModel(), x, y);

  @override
  void apply(Apply<A> fn) {
    fn(_prepareAccumulator());
  }

  @override
  void applyUnary<X>(ApplyUnary<A, X> fn, X x) {
    fn(_prepareAccumulator(), x);
  }

  @override
  void applyBinary<X, Y>(ApplyBinary<A, X, Y> fn, X x, Y y) {
    fn(_prepareAccumulator(), x, y);
  }

  void sinkChange() {
    if (!_hasPossibleChange) return;
    _change.add(_prepareModel());
  }

  Future<void> teardown() => _change.close();

  M _prepareModel() =>
      _model = _hasPossibleChange ? _getModel(_accumulator) : _model;

  A _prepareAccumulator() {
    if (!_hasPossibleChange) _context.registerPossibleChange(A);
    return _accumulator;
  }
}
