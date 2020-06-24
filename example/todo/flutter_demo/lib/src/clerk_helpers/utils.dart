import 'package:clerk/clerk.dart';

import 'types.dart';

extension StoreExecutorUtils on StoreExecutor {
  Callback bind(
    ActionsFactory createActions,
  ) =>
      ([_, __]) {
        createActions().forEach(execute);
      };

  CallbackUnary<X> bindUnary<X>(
    ActionsFactoryUnary<X> createActions,
  ) =>
      (x, [_]) {
        createActions(x).forEach(execute);
      };

  CallbackBinary<X, Y> bindBinary<X, Y>(
    ActionsFactoryBinary<X, Y> createActions,
  ) =>
      (x, y) {
        createActions(x, y).forEach(execute);
      };
}
