import 'interfaces_public.dart';

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

/// Type of a function that writes data to a complex object.
typedef Write<A, V> = V Function(A);

/// Type of a function that writes data to a complex object.
///
/// Accepts an additional argument to influence the writing.
typedef WriteUnary<A, V, X> = V Function(A, X);

/// Type of a function that writes data to a complex object.
///
/// Accepts an additional arguments to influence the writing.
typedef WriteBinary<A, V, X, Y> = V Function(A, X, Y);

/// Type of a callback that returns accumulator from model.
typedef GetAccumulator<M, A> = A Function(M);

/// Type of a callback that returns model from accumulator.
typedef GetModel<M, A> = M Function(A);

/// Type of a callback that compares two models.
typedef CompareModels<M> = bool Function(M, M);

/// Type of a function that works with store by [StoreManager].
typedef Execute = void Function(StoreManager);
