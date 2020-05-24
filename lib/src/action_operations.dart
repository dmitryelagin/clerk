import 'dart:async';

import 'public_types.dart';

/// Runs [ActionOperation] asynchronously.
ActionOperation executeAsync(ActionOperation execute) => (store) {
      Timer.run(() {
        execute(store);
      });
    };

/// Runs [ActionOperation] in microtask.
ActionOperation executeMicrotask(ActionOperation execute) => (store) {
      scheduleMicrotask(() {
        execute(store);
      });
    };

/// Runs just a single [Writer].
ActionOperation executeWriter<A, V>(
  Writer<A, V> write,
) =>
    (store) {
      store.assign(write);
    };

/// Runs just a single [WriterUnary] with provided argument.
ActionOperation executeUnaryWriter<A, V, X>(
  WriterUnary<A, V, X> write,
  X x,
) =>
    (store) {
      store.assignUnary(write, x);
    };

/// Runs just a single [WriterBinary] with provided arguments.
ActionOperation executeBinaryWriter<A, V, X, Y>(
  WriterBinary<A, V, X, Y> write,
  X x,
  Y y,
) =>
    (store) {
      store.assignBinary(write, x, y);
    };
