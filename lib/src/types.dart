import 'dart:async';

import 'interfaces.dart';

/// Type of a function that works with store by [StoreManager].
typedef Run = void Function(StoreManager);

/// Type of a function that works with store by [StoreManager].
///
/// Accepts an additional argument.
typedef RunUnary<X> = void Function(StoreManager, X);

/// Type of a function that works with store by [StoreManager].
///
/// Accepts an additional arguments.
typedef RunBinary<X, Y> = void Function(StoreManager, X, Y);

/// Type of a function that returns specific data from a complex object.
typedef Read<M, V> = V Function(M);

/// Type of a function that returns specific data from a complex object.
///
/// Accepts an additional argument to influence the result.
typedef ReadUnary<M, V, X> = V Function(M, X);

/// Type of a function that returns specific data from a complex object.
///
/// Accepts an additional arguments to influence the result.
typedef ReadBinary<M, V, X, Y> = V Function(M, X, Y);

/// Type of a function that applies data to a complex object.
typedef Apply<A> = dynamic Function(A);

/// Type of a function that applies data to a complex object.
///
/// Accepts an additional argument to influence the writing.
typedef ApplyUnary<A, X> = dynamic Function(A, X);

/// Type of a function that applies data to a complex object.
///
/// Accepts an additional arguments to influence the writing.
typedef ApplyBinary<A, X, Y> = dynamic Function(A, X, Y);

/// Type of a callback that returns accumulator from model.
typedef GetAccumulator<M, A> = A Function(M);

/// Type of a callback that returns model from accumulator.
typedef GetModel<M, A> = M Function(A);

/// Type of a callback that compares two models.
typedef CompareModels<M> = bool Function(M, M);

typedef GetStream = Stream<T> Function<T>();
typedef GetStreamController = StreamController<T> Function<T>();
typedef ReadFallback = T Function<T>(Type, Type, [Object, Object]);
typedef ApplyFallback = void Function(Type, [Object, Object]);
