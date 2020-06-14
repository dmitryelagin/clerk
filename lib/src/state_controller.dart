import 'dart:async';

import 'interfaces_private.dart';
import 'store_settings.dart';
import 'types_public.dart';

class StateController<M extends Object, A extends Object>
    implements StateManager<M, A> {
  StateController(
    StoreSettings settings,
    this._accumulator,
    this._getAccumulator,
    this._getModel,
    this._areEqualModels,
  )   : _model = _getModel(_accumulator),
        _change = settings.getStreamController(),
        _afterChanges = settings.getStreamController();

  final GetAccumulator<M, A> _getAccumulator;
  final GetModel<M, A> _getModel;
  final CompareModels<M> _areEqualModels;

  final StreamController<M> _change;
  final StreamController<M> _afterChanges;

  A _accumulator;
  M _model;
  M _prevModel;

  bool _hasChange = false;
  bool _hasDeferredChange = false;
  bool _hasTransanction = false;
  bool _shouldRebuild = false;

  M get model => _prepareModel();
  bool get hasChange => _hasChange;
  bool get hasDeferredChange => _hasDeferredChange;

  @override
  Stream<M> get onChange => _change.stream;

  @override
  Stream<M> get onAfterChanges => _afterChanges.stream;

  bool get _hasChangeComputed =>
      _prevModel == null || !_areEqualModels(_prevModel, _prepareModel());

  @override
  V read<V>(Read<M, V> fn) {
    return fn(_prepareModel());
  }

  @override
  V readUnary<V, X>(ReadUnary<M, V, X> fn, X x) {
    return fn(_prepareModel(), x);
  }

  @override
  V readBinary<V, X, Y>(ReadBinary<M, V, X, Y> fn, X x, Y y) {
    return fn(_prepareModel(), x, y);
  }

  @override
  void write(Write<A> fn) {
    final accumulator = _prepareAccumulator();
    _updateAccumulator(fn(accumulator), accumulator);
  }

  @override
  void writeUnary<X>(WriteUnary<A, X> fn, X x) {
    final accumulator = _prepareAccumulator();
    _updateAccumulator(fn(accumulator, x), accumulator);
  }

  @override
  void writeBinary<X, Y>(WriteBinary<A, X, Y> fn, X x, Y y) {
    final accumulator = _prepareAccumulator();
    _updateAccumulator(fn(accumulator, x, y), accumulator);
  }

  void endTransanction() {
    if (!_hasTransanction) return;
    _hasTransanction = false;
    if (_hasChange || !_hasChangeComputed) return;
    _hasChange = _hasDeferredChange = true;
  }

  void sinkChange() {
    if (!_hasChange) return;
    _change.add(_prepareModel());
    _hasChange = false;
  }

  void sinkDeferredChange() {
    if (!_hasDeferredChange) return;
    _afterChanges.add(_prepareModel());
    _hasDeferredChange = false;
  }

  Future<void> teardown() async {
    await Future.wait<void>([
      _change.close(),
      _afterChanges.close(),
    ]);
  }

  M _prepareModel() {
    if (!_shouldRebuild) return _model;
    _shouldRebuild = false;
    return _model = _getModel(_accumulator);
  }

  A _prepareAccumulator() {
    if (_hasTransanction) return _accumulator;
    _hasTransanction = true;
    _prevModel = _model;
    return _getAccumulator(_model);
  }

  void _updateAccumulator(Object value, A prevAccumulator) {
    _accumulator = value != null && value is A ? value : prevAccumulator;
    _shouldRebuild = true;
  }
}
