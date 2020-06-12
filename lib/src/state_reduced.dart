import 'state.dart';
import 'types_public.dart';

/// A simplified [State] that acts like a reducer.
class StateReduced<T extends Object> extends State<T, T> {
  /// Creates [StateReduced].
  ///
  /// This [State] needs only initial model to operate and it may help when
  /// writers act like reducers. Consider using [StateReduced] in existing
  /// code base while migrating from reducers, because this approach can
  /// cause performance issues.
  StateReduced(T initialModel, [ModelComparator<T> areEqualModels])
      : super(
          initialModel,
          (value) => value,
          (value) => value,
          areEqualModels,
        );
}
