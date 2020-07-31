import 'dart:async';

import 'state.dart';
import 'types.dart';

/// A container that provides access to all [State] models of specific store.
abstract class StateAggregate {
  /// Returns whether [StateAggregate] contains requested [State] model or not.
  bool has<T>();

  /// Returns [State] model with requested type.
  ///
  /// Returns `null` if [State] model was not found.
  T get<T>();
}

/// An object that can properly run [Run].
abstract class StoreExecutor {
  /// Immediately runs [Run].
  ///
  /// Every [Run] will be run in the execution zone; it is forked
  /// from the zone in which the whole store was created.
  void run(Run fn);

  /// Immediately runs [RunUnary].
  ///
  /// Every [RunUnary] will be run with the provided argument in the
  /// execution zone; it is forked from the zone in which the whole store
  /// was created.
  void runUnary<X>(RunUnary<X> fn, X x);

  /// Immediately runs [RunBinary].
  ///
  /// Every [RunBinary] will be run with the provided argument in the
  /// execution zone; it is forked from the zone in which the whole store
  /// was created.
  void runBinary<X, Y>(RunBinary<X, Y> fn, X x, Y y);
}

/// An object that gets value from store [State] model by provided callback.
abstract class StoreReader {
  /// Returns the result of [Read] execution.
  ///
  /// It will be called with required [State] model. [Read] can require
  /// [StoreReader] as the first argument, so [StoreReader] will be
  /// provided instead of model.
  V read<M, V>(Read<M, V> fn);

  /// Returns the result of [ReadUnary] execution.
  ///
  /// It will be called with required [State] model and provided
  /// additional argument. [ReadUnary] can require [StoreReader] as the
  /// first argument, so [StoreReader] will be provided instead of model.
  V readUnary<M, V, X>(ReadUnary<M, V, X> fn, X x);

  /// Returns the result of [ReadBinary] execution.
  ///
  /// It will be called with required [State] model and provided
  /// additional arguments. [ReadBinary] can require [StoreReader] as the
  /// first argument, so [StoreReader] will be provided instead of model.
  V readBinary<M, V, X, Y>(ReadBinary<M, V, X, Y> fn, X x, Y y);
}

/// An object that can execute main operations over store.
abstract class StoreManager implements StoreReader {
  /// Modifies [State] accumulator with provided [Apply].
  ///
  /// It will be called with required [State] accumulator. [Apply] can require
  /// [StoreManager] as the first argument, so [StoreManager] will be
  /// provided instead of accumulator.
  void apply<A>(Apply<A> fn);

  /// Modifies [State] accumulator with provided [ApplyUnary].
  ///
  /// It will be called with required [State] accumulator and provided
  /// argument. [ApplyUnary] can require [StoreManager] as the first argument,
  /// so [StoreManager] will be provided instead of accumulator.
  void applyUnary<A, X>(ApplyUnary<A, X> fn, X x);

  /// Modifies [State] accumulator with provided [ApplyBinary].
  ///
  /// It will be called with required [State] accumulator and provided
  /// arguments. [ApplyBinary] can require [StoreManager] as the first
  /// argument, so [StoreManager] will be provided instead of accumulator.
  void applyBinary<A, X, Y>(ApplyBinary<A, X, Y> fn, X x, Y y);
}

/// An accessor to all available store data and events.
abstract class StoreAccessor {
  /// The latest models of all store [State]s.
  StateAggregate get state;

  /// A stream that emits models of store [State]s when anything changes.
  ///
  /// Emits synchronously and only after any model was changed during
  /// [Run] run.
  Stream<StateAggregate> get onChange;

  /// A stream that emits models of store [State]s when anything changes.
  ///
  /// Emits in microtask and only after any model was changed during all
  /// [Run] runs before microtask schedule.
  Stream<StateAggregate> get onAfterChanges;

  /// Returns stream which emits specific [State] model when it changes.
  ///
  /// Emits synchronously and only when [State] model was changed during
  /// [Run] run.
  Stream<M> onModelChange<M>();

  /// Returns stream which emits specific [State] model when it changes.
  ///
  /// Emits in microtask and only when [State] model was changed during all
  /// [Run] runs before microtask schedule.
  Stream<M> onAfterModelChanges<M>();
}

abstract class StateManager<M extends Object, A extends Object> {
  Stream<M> get onChange;
  Stream<M> get onAfterChanges;
  V read<V>(Read<M, V> fn);
  V readUnary<V, X>(ReadUnary<M, V, X> fn, X x);
  V readBinary<V, X, Y>(ReadBinary<M, V, X, Y> fn, X x, Y y);
  void apply(Apply<A> fn);
  void applyUnary<X>(ApplyUnary<A, X> fn, X x);
  void applyBinary<X, Y>(ApplyBinary<A, X, Y> fn, X x, Y y);
}
