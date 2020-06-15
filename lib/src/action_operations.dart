import 'dart:async';

import 'types_public.dart';

/// Runs [Execute] asynchronously.
Execute executeAsync(Execute execute) {
  return (store) {
    Timer.run(() {
      execute(store);
    });
  };
}

/// Runs [Execute] in microtask.
Execute executeMicrotask(Execute execute) {
  return (store) {
    scheduleMicrotask(() {
      execute(store);
    });
  };
}

/// Runs just a single [Write].
Execute executeWrite<A, V>(Write<A, V> fn) {
  return (store) {
    store.write(fn);
  };
}

/// Runs just a single [WriteUnary] with provided argument.
Execute executeWriteUnary<A, V, X>(WriteUnary<A, V, X> fn, X x) {
  return (store) {
    store.writeUnary(fn, x);
  };
}

/// Runs just a single [WriteBinary] with provided arguments.
Execute executeWriteBinary<A, V, X, Y>(WriteBinary<A, V, X, Y> fn, X x, Y y) {
  return (store) {
    store.writeBinary(fn, x, y);
  };
}
