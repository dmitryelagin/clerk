import 'interfaces_public.dart';
import 'map_type_utils.dart';

class StateAggregateImpl implements StateAggregate {
  const StateAggregateImpl(this._models);

  static const empty = StateAggregateImpl({});

  final Map<Type, Object> _models;

  @override
  bool has<T>() => _models.containsKey(T);

  @override
  T get<T>() => _models.get(T);
}
