import 'interfaces.dart';
import 'map_utils.dart';

class StateAggregateImpl implements StateAggregate {
  const StateAggregateImpl(this._models);

  final Map<Type, Object?> _models;

  @override
  bool has<T>() => _models.containsKey(T);

  @override
  T? get<T>() => _models.get(T);
}
