import 'dart:async';

import 'state.dart';
import 'types.dart';

/// An object that can read from or apply to store.
abstract class StoreManager implements StoreExecutor, StoreReader {}

/// An object that can execute operations over store.
abstract class StoreExecutor {
  /// Modifies [State] accumulator with provided [Apply].
  ///
  /// Every [Apply] will be run in the execution zone; it is forked
  /// from the zone in which the whole store was created. It will be called
  /// with required [State] accumulator. [Apply] can require [StoreManager]
  /// [StoreExecutor] or [StoreReader] as the first argument, so the
  /// appropriate object will be provided instead of accumulator.
  void apply<A>(Apply<A> fn);

  /// Modifies [State] accumulator with provided [ApplyUnary].
  ///
  /// Every [ApplyUnary] will be run with the provided argument in the
  /// execution zone; it is forked from the zone in which the whole store
  /// was created. It will be called with required [State] accumulator and
  /// provided argument. [ApplyUnary] can require [StoreManager]
  /// [StoreExecutor] or [StoreReader] as the first argument, so the
  /// appropriate object will be provided instead of accumulator.
  void applyUnary<A, X>(ApplyUnary<A, X> fn, X x);

  /// Modifies [State] accumulator with provided [ApplyBinary].
  ///
  /// Every [ApplyBinary] will be run with the provided argument in the
  /// execution zone; it is forked from the zone in which the whole store
  /// was created. It will be called with required [State] accumulator and
  /// provided arguments. [ApplyBinary] can require [StoreManager]
  /// [StoreExecutor] or [StoreReader] as the first argument, so the
  /// appropriate object will be provided instead of accumulator.
  void applyBinary<A, X, Y>(ApplyBinary<A, X, Y> fn, X x, Y y);
}

/// An object that gets value from store [State] model with provided callback.
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

/// An accessor to all available store data and events.
abstract class StoreAccessor<S> {
  /// The latest models of all store [State]s.
  S get state;

  /// A stream that emits models of store [State]s when anything changes.
  ///
  /// Emits only after any model was changed during [Apply] run. [Stream]
  /// type can make emission synchronous or asynchronous.
  Stream<S> get onChange;

  /// Returns stream which emits specific [State] model when it changes.
  ///
  /// Emits only when [State] model was changed during [Apply] run. [Stream]
  /// type can make emission synchronous or asynchronous.
  Stream<M> onModelChange<M>();
}

abstract class ContextManager {
  bool get hasPossibleChanges;
  bool hasPossibleChange(Type key);
  void registerPossibleChange(Type key);
}

abstract class ExecutionHelper {
  void run(
    void Function() fn, {
    Zone? source,
    ZoneSpecification? zoneSpecification,
  });
}
