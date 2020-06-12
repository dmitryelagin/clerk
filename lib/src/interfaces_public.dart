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

/// An object that can assemble store from multiple [State].
abstract class StoreComposer {
  /// Adds [State] to [StoreComposer] store.
  ///
  /// [State] model becomes available and typed stream from
  /// [StoreChangeEventBus.onModelChange] method can be returned instead
  /// of `null` right after this method was called.
  void add<M, A>(State<M, A> value);

  /// Removes state from [StoreComposer] store.
  ///
  /// [State] model becomes unavailable and typed streams from
  /// [StoreChangeEventBus.onModelChange] method are closed right after
  /// this method was called.
  void remove<T>();
}

/// An object that can properly execute [Action].
abstract class StoreExecutor {
  /// Immediately starts [Action] execution.
  ///
  /// Every [Action] will be executed in the execution zone; it is forked
  /// from the zone in which the whole store was created.
  void execute(Action action);
}

/// An object that gets value from store [State] model with provided selector.
abstract class StoreEvaluator {
  /// Returns the result of [Selector] execution.
  ///
  /// It will be called with required [State] model. Returns `null` and
  /// emits event to [StoreFailureEventBus.onEvaluationFailed] if required
  /// [State] was not found. [Selector] can have [StoreEvaluator] as the first
  /// argument, so [StoreEvaluator] will be provided instead of model.
  V evaluate<M, V>(Selector<M, V> select);

  /// Returns the result of [SelectorUnary] execution.
  ///
  /// It will be called with required [State] model and provided
  /// additional argument. Returns `null` and emits event to
  /// [StoreFailureEventBus.onEvaluationFailed] if required [State]
  /// was not found. [SelectorUnary] can have [StoreEvaluator] as the first
  /// argument, so [StoreEvaluator] will be provided instead of model.
  V evaluateUnary<M, V, X>(SelectorUnary<M, V, X> select, X x);

  /// Returns the result of [SelectorBinary] execution.
  ///
  /// It will be called with required [State] model and provided
  /// additional arguments. Returns `null` and emits event to
  /// [StoreFailureEventBus.onEvaluationFailed] if required [State]
  /// was not found. [SelectorBinary] can have [StoreEvaluator] as the first
  /// argument, so [StoreEvaluator] will be provided instead of model.
  V evaluateBinary<M, V, X, Y>(SelectorBinary<M, V, X, Y> select, X x, Y y);
}

/// An object that can execute most available operations over store.
abstract class StoreManager implements StoreExecutor, StoreEvaluator {
  /// Modifies [State] accumulator with provided [Writer].
  ///
  /// Writer will be called with required [State] accumulator. Emits
  /// event to [StoreFailureEventBus.onAssignmentFailed] if required
  /// [State] was not found.
  void assign<A, V>(Writer<A, V> write);

  /// Modifies [State] accumulator with provided [WriterUnary].
  ///
  /// Writer will be called with required [State] accumulator and provided
  /// argument. Emits event to [StoreFailureEventBus.onAssignmentFailed]
  /// if required [State] was not found.
  void assignUnary<A, V, X>(WriterUnary<A, V, X> write, X x);

  /// Modifies [State] accumulator with provided [WriterBinary].
  ///
  /// Writer will be called with required [State] accumulator and provided
  /// arguments. Emits event to [StoreFailureEventBus.onAssignmentFailed]
  /// if required [State] was not found.
  void assignBinary<A, V, X, Y>(WriterBinary<A, V, X, Y> write, X x, Y y);
}

/// An accessor to all available store data.
abstract class StoreAccessor
    implements StoreChangeEventBus, StoreActionEventBus, StoreFailureEventBus {
  /// The latest models of all store [State]s.
  StateAggregate get state;
}

/// A bus for [Action] related events.
abstract class StoreActionEventBus {
  /// A stream that emits [Action] before its execution.
  Stream<Action> get onBeforeAction;

  /// A stream that emits [Action] after its execution.
  Stream<Action> get onAfterAction;
}

/// A bus for failure events.
abstract class StoreFailureEventBus {
  /// A stream that emits model type when [State] was not found.
  ///
  /// Emits if type of [State] model was not found before any evaluation.
  Stream<Type> get onEvaluationFailed;

  /// A stream that emits accumulator type when [State] was not found.
  ///
  /// Emits if type of [State] accumulator was not found before any assignment.
  Stream<Type> get onAssignmentFailed;

  /// A stream that emits model type when [State] was not found.
  ///
  /// Emits if type of [State] model was not found before listening for its
  /// changes.
  Stream<Type> get onListenChangeFailed;

  /// A stream that emits model type when [State] was not found.
  ///
  /// Emits if type of [State] model was not found before listening for all
  /// its changes.
  Stream<Type> get onListenAfterChangesFailed;
}

/// A bus for change related events.
abstract class StoreChangeEventBus {
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

  /// Returns stream which emits specific [State] model when it changes.
  ///
  /// Emits synchronously and only when [State] model was changed during
  /// [Action] execution. Returns [Stream.empty()] and emits event to
  /// [StoreFailureEventBus.onListenChangeFailed] if store does not have
  /// the requested [State].
  Stream<M> onModelChange<M>();

  /// Returns stream which emits specific [State] model when it changes.
  ///
  /// Emits in microtask and only when [State] model was changed during all
  /// [Action] executions before microtask schedule. Returns [Stream.empty()]
  /// and emits event to [StoreFailureEventBus.onListenAfterChangesFailed]
  /// if store does not have the requested [State].
  Stream<M> onAfterModelChanges<M>();
}
