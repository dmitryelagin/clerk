import 'state.dart';
import 'types.dart';
import 'utils.dart';

/// A simplified [State] that acts like a reducer.
class ReducedState<T extends Object> extends State<T, T> {
  /// Creates [ReducedState].
  ///
  /// This [State] needs only initial model to operate and it may help when
  /// writers act like reducers, but this approach can cause performance
  /// issues. Prefer using [ReducedState] in existing code base while migrating
  /// from reducers.
  ReducedState(T initialModel, [ModelComparator<T> areEqualModels = areEqual])
      : super(
          (value) => value ?? initialModel,
          (value) => value,
          areEqualModels,
        );
}
