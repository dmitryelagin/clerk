import 'dart:async';

import 'types_public.dart';

/// Runs [ActionOperation] asynchronously.
ActionOperation executeAsync(ActionOperation execute) {
  return (store) {
    Timer.run(() {
      execute(store);
    });
  };
}

/// Runs [ActionOperation] in microtask.
ActionOperation executeMicrotask(ActionOperation execute) {
  return (store) {
    scheduleMicrotask(() {
      execute(store);
    });
  };
}

/// Runs just a single [Writer].
ActionOperation executeWriter<A, V>(
  Writer<A, V> write,
) {
  return (store) {
    store.assign(write);
  };
}

/// Runs just a single [WriterUnary] with provided argument.
ActionOperation executeUnaryWriter<A, V, X>(
  WriterUnary<A, V, X> write,
  X x,
) {
  return (store) {
    store.assignUnary(write, x);
  };
}

/// Runs just a single [WriterBinary] with provided arguments.
ActionOperation executeBinaryWriter<A, V, X, Y>(
  WriterBinary<A, V, X, Y> write,
  X x,
  Y y,
) {
  return (store) {
    store.assignBinary(write, x, y);
  };
}
