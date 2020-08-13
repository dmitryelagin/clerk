/// A container of rules for working with specific model and accumulator.
///
/// [State] object works with model and accumulator concepts. Model is the
/// representation of data. In most cases it should be immutable. Accumulator
/// is the representation of object that can handle changes for model. In most
/// cases it should be mutable. The methods of [State] should define the rules
/// of how to get accumulator from model (before modifying accumulator),
/// how to get model from accumulator (after modifying accumulator) and how
/// to compare models to determine if the model has been changed.
class State<M extends Object, A extends Object> {
  /// Creates [State] with provided rules.
  ///
  /// Callbacks will be executed as if they are appropriate methods.
  const State(
    this.accumulator, {
    required M Function(A) getModel,
    bool Function(M, M) areEqualModels = identical,
  })  : _getModel = getModel,
        _areEqualModels = areEqualModels;

  /// An accumulator object.
  ///
  /// It will be [State]'s permanent accumulator and will act as a single
  /// source of truth. Store will read accumulator only once and then it will
  /// remain preserved internally.
  final A accumulator;

  final M Function(A) _getModel;
  final bool Function(M, M) _areEqualModels;

  /// Returns model produced from accumulator.
  M getModel(A accumulator) => _getModel(accumulator);

  /// Returns whether two models are equal or not.
  ///
  /// It uses [identical] function by default.
  bool areEqualModels(M a, M b) => _areEqualModels(a, b);
}
