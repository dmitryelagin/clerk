import 'dart:async';

import 'action.dart';

abstract class StoreController {
  bool get isTeardowned;
  bool get hasTransanction;
  void beginTransanction();
  void endTransanction();
}

abstract class StoreActionEventBusController {
  StreamController<Action> get beforeAction;
  StreamController<Action> get afterAction;
  StreamController<Type> get evaluationFailed;
  StreamController<Type> get assignmentFailed;
}

abstract class StoreChangeEventBusController {
  void connect<M>(Stream<M> changes);
  void disconnect<M>();
  void endTransanction();
}

abstract class StoreEventBusController
    implements StoreActionEventBusController, StoreChangeEventBusController {}
