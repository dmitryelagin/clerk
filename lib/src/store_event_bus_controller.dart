import 'dart:async';

import 'action.dart';
import 'interfaces_private.dart';
import 'interfaces_public.dart';

class StoreEventBusController
    implements
        StoreChangeEventBusController,
        StoreActionEventBusController,
        StoreFailureEventBusController {
  @override
  final StreamController<StateAggregate> change = _createController();

  @override
  final StreamController<StateAggregate> afterChanges = _createController();

  @override
  final StreamController<Action> beforeAction = _createController();

  @override
  final StreamController<Action> afterAction = _createController();

  @override
  final StreamController<Type> evaluationFailed = _createController();

  @override
  final StreamController<Type> assignmentFailed = _createController();

  @override
  final StreamController<Type> listenChangeFailed = _createController();

  @override
  final StreamController<Type> listenAfterChangesFailed = _createController();

  static StreamController<T> _createController<T>() =>
      StreamController.broadcast(sync: true);

  void teardown() {
    change.close();
    afterChanges.close();
    beforeAction.close();
    afterAction.close();
    evaluationFailed.close();
    assignmentFailed.close();
    listenChangeFailed.close();
    listenAfterChangesFailed.close();
  }
}
