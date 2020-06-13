import 'dart:async';

import 'action.dart';
import 'interfaces_public.dart';
import 'types_public.dart';

abstract class StateManager<M extends Object, A extends Object> {
  Stream<M> get onChange;
  Stream<M> get onAfterChanges;
  V evaluate<V>(Selector<M, V> select);
  V evaluateUnary<V, X>(SelectorUnary<M, V, X> select, X x);
  V evaluateBinary<V, X, Y>(SelectorBinary<M, V, X, Y> select, X x, Y y);
  void assign<V>(Writer<A, V> write);
  void assignUnary<V, X>(WriterUnary<A, V, X> write, X x);
  void assignBinary<V, X, Y>(WriterBinary<A, V, X, Y> write, X x, Y y);
}

abstract class StoreController {
  bool get isTeardowned;
  bool get canNotStartTransanction;
  void beginTransanction();
  void endTransanction();
}

abstract class StoreActionEventBusController {
  StreamController<Action> get beforeAction;
  StreamController<Action> get afterAction;
}

abstract class StoreChangeEventBusController {
  StreamController<StateAggregate> get change;
  StreamController<StateAggregate> get afterChanges;
}
