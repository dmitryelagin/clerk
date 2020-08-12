import 'dart:async';

import 'interfaces.dart';
import 'state.dart';

class StateController<M extends Object, A extends Object> {
  StateController(this._state, this._context, this._change)
      : _accumulator = _state.accumulator {
    _model = _prevModel = _state.getModel(_accumulator);
  }

  final A _accumulator;
  final State<M, A> _state;
  final ContextManager _context;
  final StreamController<M> _change;

  M _model;
  M _prevModel;

  Stream<M> get onChange => _change.stream;

  A get accumulator {
    _context.registerPossibleChange(A);
    return _accumulator;
  }

  M get model {
    if (!_context.hasPossibleChange(A)) return _model;
    return _model = _state.getModel(_accumulator);
  }

  bool trySinkChange() {
    if (!_context.hasPossibleChange(A)) return false;
    if (_state.areEqualModels(_prevModel, model)) return false;
    _change.add(_prevModel = _model);
    return true;
  }

  Future<void> teardown() => _change.close();
}
