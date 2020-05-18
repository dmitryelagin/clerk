import 'public_interfaces.dart';

/// Type of a function that returns specific data from a complex object.
typedef Selector<M, V> = V Function(M);

/// Type of a function that returns specific data from a complex object.
///
/// Accepts an additional argument to influence the result.
typedef SelectorUnary<M, V, X> = V Function(M, X);

/// Type of a function that returns specific data from a complex object.
///
/// Accepts an additional arguments to influence the result.
typedef SelectorBinary<M, V, X, Y> = V Function(M, X, Y);

/// Type of a function that writes data to a complex object.
typedef Writer<A, V> = V Function(A);

/// Type of a function that writes data to a complex object.
///
/// Accepts an additional argument to influence the writing.
typedef WriterUnary<A, V, X> = V Function(A, X);

/// Type of a function that writes data to a complex object.
///
/// Accepts an additional arguments to influence the writing.
typedef WriterBinary<A, V, X, Y> = V Function(A, X, Y);

/// Type of a callback that returns accumulator from model.
typedef AccumulatorFactory<M, A> = A Function(M);

/// Type of a callback that returns model from accumulator.
typedef ModelFactory<M, A> = M Function(A);

/// Type of a callback that compares two models.
typedef ModelComparator<M> = bool Function(M, M);

/// Type of a function that works with store by [StoreManager].
typedef ActionOperation = void Function(StoreManager);
