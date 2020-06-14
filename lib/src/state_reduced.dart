import 'state.dart';
import 'types_public.dart';

/// A simplified [State] that acts like a reducer.
class StateReduced<T> extends State<T, T> {
  /// Creates [StateReduced].
  ///
  /// This [State] needs only initial model to operate and it may help when
  /// write callbacks act like reducers. Consider using [StateReduced] in
  /// existing code base while migrating from reducers, because this approach
  /// can cause performance issues.
  StateReduced(T initialModel, [CompareModels<T>? areEqualModels])
      : super(
          initialModel,
          getModel: (value) => value,
          getAccumulator: (value) => value,
          areEqualModels: areEqualModels,
        );
}
