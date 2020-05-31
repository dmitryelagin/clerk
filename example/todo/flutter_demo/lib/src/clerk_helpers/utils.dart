import 'package:clerk/clerk.dart';

import 'types.dart';

extension StoreExecutorUtils on StoreExecutor {
  Callback bind(
    ActionFactory createAction,
  ) =>
      ([_, __]) {
        execute(createAction());
      };

  CallbackUnary<X> bindUnary<X>(
    ActionFactoryUnary<X> createAction,
  ) =>
      (x, [_]) {
        execute(createAction(x));
      };

  CallbackBinary<X, Y> bindBinary<X, Y>(
    ActionFactoryBinary<X, Y> createAction,
  ) =>
      (x, y) {
        execute(createAction(x, y));
      };
}
