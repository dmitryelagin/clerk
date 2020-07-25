import 'dart:async';

import 'state.dart';
import 'types_public.dart';

/// A container that provides access to all [State] models of specific store.
abstract class StateAggregate {
  /// Returns whether [StateAggregate] contains requested [State] model or not.
  bool has<T>();

  /// Returns [State] model with requested type.
  ///
  /// Returns `null` if [State] model was not found.
  T get<T>();
}

/// An object that can properly run [Execute].
abstract class StoreExecutor {
  /// Immediately runs [Execute].
  ///
  /// Every [Execute] will be run in the execution zone; it is forked
  /// from the zone in which the whole store was created.
  void execute(Execute fn);

  /// Immediately runs [ExecuteUnary].
  ///
  /// Every [ExecuteUnary] will be run with the provided argument in the
  /// execution zone; it is forked from the zone in which the whole store
  /// was created.
  void executeUnary<X>(ExecuteUnary<X> fn, X x);

  /// Immediately runs [ExecuteBinary].
  ///
  /// Every [ExecuteBinary] will be run with the provided argument in the
  /// execution zone; it is forked from the zone in which the whole store
  /// was created.
  void executeBinary<X, Y>(ExecuteBinary<X, Y> fn, X x, Y y);
}

/// An object that gets value from store [State] model by provided callback.
abstract class StoreReader {
  /// Returns the result of [Read] execution.
  ///
  /// It will be called with required [State] model. [Read] can have
  /// [StoreReader] as the first argument, so [StoreReader] will be
  /// provided instead of model.
  V read<M, V>(Read<M, V> fn);

  /// Returns the result of [ReadUnary] execution.
  ///
  /// It will be called with required [State] model and provided
  /// additional argument. [ReadUnary] can have [StoreReader] as the
  /// first argument, so [StoreReader] will be provided instead of model.
  V readUnary<M, V, X>(ReadUnary<M, V, X> fn, X x);

  /// Returns the result of [ReadBinary] execution.
  ///
  /// It will be called with required [State] model and provided
  /// additional arguments. [ReadBinary] can have [StoreReader] as the
  /// first argument, so [StoreReader] will be provided instead of model.
  V readBinary<M, V, X, Y>(ReadBinary<M, V, X, Y> fn, X x, Y y);
}

/// An object that can execute most available operations over store.
abstract class StoreManager implements StoreExecutor, StoreReader {
  /// Modifies [State] accumulator with provided [Write].
  ///
  /// It will be called with required [State] accumulator.
  void write<A>(Write<A> fn);

  /// Modifies [State] accumulator with provided [WriteUnary].
  ///
  /// It will be called with required [State] accumulator and provided
  /// argument.
  void writeUnary<A, X>(WriteUnary<A, X> fn, X x);

  /// Modifies [State] accumulator with provided [WriteBinary].
  ///
  /// It will be called with required [State] accumulator and provided
  /// arguments.
  void writeBinary<A, X, Y>(WriteBinary<A, X, Y> fn, X x, Y y);
}

/// An accessor to all available store data and events.
abstract class StoreAccessor {
  /// The latest models of all store [State]s.
  StateAggregate get state;

  /// A stream that emits models of store [State]s when anything changes.
  ///
  /// Emits synchronously and only after any model was changed during
  /// [Execute] run.
  Stream<StateAggregate> get onChange;

  /// A stream that emits models of store [State]s when anything changes.
  ///
  /// Emits in microtask and only after any model was changed during all
  /// [Execute] runs before microtask schedule.
  Stream<StateAggregate> get onAfterChanges;

  /// Returns stream which emits specific [State] model when it changes.
  ///
  /// Emits synchronously and only when [State] model was changed during
  /// [Execute] run.
  Stream<M> onModelChange<M>();

  /// Returns stream which emits specific [State] model when it changes.
  ///
  /// Emits in microtask and only when [State] model was changed during all
  /// [Execute] runs before microtask schedule.
  Stream<M> onAfterModelChanges<M>();
}
