import 'dart:async';

import 'action.dart';
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

/// An object that can properly execute [Action].
abstract class StoreExecutor {
  /// Immediately starts [Action] execution.
  ///
  /// Every [Action] will be executed in the execution zone; it is forked
  /// from the zone in which the whole store was created.
  void execute(Action action);
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
  void write<A, V>(Write<A, V> fn);

  /// Modifies [State] accumulator with provided [WriteUnary].
  ///
  /// It will be called with required [State] accumulator and provided
  /// argument.
  void writeUnary<A, V, X>(WriteUnary<A, V, X> fn, X x);

  /// Modifies [State] accumulator with provided [WriteBinary].
  ///
  /// It will be called with required [State] accumulator and provided
  /// arguments.
  void writeBinary<A, V, X, Y>(WriteBinary<A, V, X, Y> fn, X x, Y y);
}

/// An accessor to all available store data and events.
abstract class StoreAccessor {
  /// The latest models of all store [State]s.
  StateAggregate get state;

  /// A stream that emits models of store [State]s when anything changes.
  ///
  /// Emits synchronously and only when at least one of models was changed
  /// during [Action] execution.
  Stream<StateAggregate> get onChange;

  /// A stream that emits models of store [State]s when anything changes.
  ///
  /// Emits in microtask and only when at least one of models was changed
  /// during all [Action] executions before microtask schedule.
  Stream<StateAggregate> get onAfterChanges;

  /// A stream that emits [Action] before its execution.
  Stream<Action> get onAction;

  /// Returns stream which emits specific [State] model when it changes.
  ///
  /// Emits synchronously and only when [State] model was changed during
  /// [Action] execution.
  Stream<M> onModelChange<M>();

  /// Returns stream which emits specific [State] model when it changes.
  ///
  /// Emits in microtask and only when [State] model was changed during all
  /// [Action] executions before microtask schedule.
  Stream<M> onAfterModelChanges<M>();
}
