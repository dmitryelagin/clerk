import 'package:clerk/clerk.dart';

import 'types.dart';

extension StoreExecutorUtils on StoreExecutor {
  Callback bind(
    ActionFactory createActions,
  ) =>
      ([_, __]) {
        execute(createActions());
      };

  CallbackUnary<X> bindUnary<X>(
    ActionFactoryUnary<X> createActions,
  ) =>
      (x, [_]) {
        execute(createActions(x));
      };

  CallbackBinary<X, Y> bindBinary<X, Y>(
    ActionFactoryBinary<X, Y> createActions,
  ) =>
      (x, y) {
        execute(createActions(x, y));
      };
}
