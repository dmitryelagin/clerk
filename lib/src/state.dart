import 'types.dart';

/// A container of rules for working with specific model and accumulator.
///
/// [State] object works with model and accumulator concepts. Model is the
/// representation of data. In most cases it should be immutable. Accumulator
/// is the representation of object that can handle changes for model. In most
/// cases it should be mutable. The methods of [State] should define the rules
/// of how to get accumulator from model (before modifying accumulator),
/// how to get model from accumulator (after modifying accumulator) and how
/// to compare models to determine if the model has been changed.
class State<M, A> {
  /// Creates [State] with provided rules.
  ///
  /// Callbacks will be executed as if they are appropriate methods.
  const State(
    this.accumulator, {
    required GetModel<M, A> getModel,
    CompareModels<M>? areEqualModels,
  })  : _getModel = getModel,
        _areEqualModels = areEqualModels ?? identical;

  /// An accumulator object.
  ///
  /// It will be [State]'s permanent accumulator and will act as a single
  /// source of truth.
  final A accumulator;

  final GetModel<M, A> _getModel;
  final CompareModels<M> _areEqualModels;

  /// Returns model produced from accumulator.
  M getModel(A accumulator) => _getModel(accumulator);

  /// Returns whether two models are equal or not.
  ///
  /// It uses [identical] function by default.
  bool areEqualModels(M a, M b) => _areEqualModels(a, b);
}
