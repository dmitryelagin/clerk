import 'types_public.dart';

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
  State(
    this.initial,
    this._getModel, [
    AccumulatorFactory<M, A> getAccumulator,
    ModelComparator<M> areEqualModels,
  ])  : _getAccumulator = getAccumulator ?? ((_) => initial),
        _areEqualModels = areEqualModels ?? identical;

  /// Initial accumulator object.
  ///
  /// It will be [State]'s permanent accumulator and will act as a single
  /// source of truth if [AccumulatorFactory] is not provided.
  final A initial;

  final AccumulatorFactory<M, A> _getAccumulator;
  final ModelFactory<M, A> _getModel;
  final ModelComparator<M> _areEqualModels;

  /// Returns accumulator produced from model.
  A getAccumulator(M model) => _getAccumulator(model);

  /// Returns model produced from accumulator.
  M getModel(A accumulator) => _getModel(accumulator);

  /// Returns whether two models are equal or not.
  ///
  /// It uses [identical] function by default.
  bool areEqualModels(M a, M b) => _areEqualModels(a, b);
}
