import 'dart:async';

import 'interfaces_private.dart';
import 'types_public.dart';

class StateController<M extends Object, A extends Object>
    implements StateManager<M, A> {
  StateController(
    this._accumulator,
    this._getAccumulator,
    this._getModel,
    this._areEqualModels,
  ) {
    _model = _getModel(_accumulator);
  }

  final AccumulatorFactory<M, A> _getAccumulator;
  final ModelFactory<M, A> _getModel;
  final ModelComparator<M> _areEqualModels;

  final _change = StreamController<M>.broadcast(sync: true);
  final _afterChanges = StreamController<M>.broadcast(sync: true);

  A _accumulator;
  M _prevModel;
  M _model;

  bool _hasChange = false;
  bool _hasDeferredChange = false;
  bool _hasTransanction = false;
  bool _shouldRebuild = false;

  M get model => _model;
  bool get hasChange => _hasChange;
  bool get hasDeferredChange => _hasDeferredChange;

  @override
  Stream<M> get onChange => _change.stream;

  @override
  Stream<M> get onAfterChanges => _afterChanges.stream;

  @override
  V evaluate<V>(Selector<M, V> select) {
    return select(_evaluateModel());
  }

  @override
  V evaluateUnary<V, X>(SelectorUnary<M, V, X> select, X x) {
    return select(_evaluateModel(), x);
  }

  @override
  V evaluateBinary<V, X, Y>(SelectorBinary<M, V, X, Y> select, X x, Y y) {
    return select(_evaluateModel(), x, y);
  }

  @override
  void assign<V>(Writer<A, V> write) {
    _updateAccumulator(write(_prepareAssignment()));
  }

  @override
  void assignUnary<V, X>(WriterUnary<A, V, X> write, X x) {
    _updateAccumulator(write(_prepareAssignment(), x));
  }

  @override
  void assignBinary<V, X, Y>(WriterBinary<A, V, X, Y> write, X x, Y y) {
    _updateAccumulator(write(_prepareAssignment(), x, y));
  }

  void endTransanction() {
    if (!_hasTransanction) return;
    _hasTransanction = false;
    if (_areEqualModels(_prevModel, _evaluateModel())) return;
    _hasChange = _hasDeferredChange = true;
  }

  void sinkChange() {
    if (!_hasChange) return;
    _change.add(_model);
    _hasChange = false;
  }

  void sinkDeferredChange() {
    if (!_hasDeferredChange) return;
    _afterChanges.add(_model);
    _hasDeferredChange = false;
  }

  void teardown() {
    _change.close();
    _afterChanges.close();
  }

  M _evaluateModel() {
    if (!_shouldRebuild) return _model;
    _shouldRebuild = false;
    return _model = _getModel(_accumulator);
  }

  A _prepareAssignment() {
    if (_hasTransanction) return _accumulator;
    _hasTransanction = true;
    _prevModel = _model;
    return _getAccumulator(_model);
  }

  void _updateAccumulator<T>(T value) {
    _accumulator = value != null && value is A ? value : _accumulator;
    _shouldRebuild = true;
  }
}
