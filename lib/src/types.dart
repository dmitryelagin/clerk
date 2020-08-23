import 'dart:async';

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
typedef Apply<A> = FutureOr<void> Function(A);

/// Type of a function that applies data to a complex object.
///
/// Accepts an additional argument to influence the writing.
typedef ApplyUnary<A, X> = FutureOr<void> Function(A, X);

/// Type of a function that applies data to a complex object.
///
/// Accepts an additional arguments to influence the writing.
typedef ApplyBinary<A, X, Y> = FutureOr<void> Function(A, X, Y);
