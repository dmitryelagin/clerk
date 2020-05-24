import 'dart:async';

import 'public_types.dart';
import 'state.dart';

class StateManager<M extends Object, A extends Object> {
  StateManager(this._getAccumulator, this._getModel, this._areEqualModels) {
    _accumulator = _getAccumulator(null);
    _model = _getModel(_accumulator);
  }

  factory StateManager.fromState(State<M, A> state) =>
      StateManager(state.getAccumulator, state.getModel, state.areEqualModels);

  final AccumulatorFactory<M, A> _getAccumulator;
  final ModelFactory<M, A> _getModel;
  final ModelComparator<M> _areEqualModels;

  final _change = StreamController<M>(sync: true);

  A _accumulator;
  M _prevModel;
  M _model;

  bool _hasTransanction = false;
  bool _isChanged = false;

  M get model => _model;

  Stream<M> get onChange => _change.stream;

  V evaluate<T, V>(Selector<T, V> select) {
    final model = _evaluateModel();
    return model is T ? select(model) : null;
  }

  V evaluateUnary<T, V, X>(SelectorUnary<T, V, X> select, X x) {
    final model = _evaluateModel();
    return model is T ? select(model, x) : null;
  }

  V evaluateBinary<T, V, X, Y>(SelectorBinary<T, V, X, Y> select, X x, Y y) {
    final model = _evaluateModel();
    return model is T ? select(model, x, y) : null;
  }

  void assign<T, V>(Writer<T, V> write) {
    final accumulator = _prepareAssignment();
    if (accumulator is T) {
      _assignAccumulator(write(accumulator));
    }
  }

  void assignUnary<T, V, X>(WriterUnary<T, V, X> write, X x) {
    final accumulator = _prepareAssignment();
    if (accumulator is T) {
      _assignAccumulator(write(accumulator, x));
    }
  }

  void assignBinary<T, V, X, Y>(WriterBinary<T, V, X, Y> write, X x, Y y) {
    final accumulator = _prepareAssignment();
    if (accumulator is T) {
      _assignAccumulator(write(accumulator, x, y));
    }
  }

  void endTransanction() {
    if (!_hasTransanction) return;
    _hasTransanction = false;
    if (_areEqualModels(_prevModel, _evaluateModel())) return;
    _change.add(_model);
  }

  void teardown() {
    _change.close();
  }

  M _evaluateModel() {
    if (!_isChanged) return _model;
    _isChanged = false;
    return _model = _getModel(_accumulator);
  }

  A _prepareAssignment() {
    if (_hasTransanction) return _accumulator;
    _hasTransanction = true;
    _prevModel = _model;
    return _getAccumulator(_model);
  }

  void _assignAccumulator<T>(T value) {
    _accumulator = value != null && value is A ? value : _accumulator;
    _isChanged = true;
  }
}
