import 'public_interfaces.dart';
import 'public_types.dart';

T asType<T>(Object value) => value as T; // ignore: avoid_as

bool areEqual(Object a, Object b) => a == b;

bool isGenericSelector<M, V>(Selector<M, V> select) =>
    select is Selector<StoreEvaluator, V>;

bool isGenericSelectorUnary<M, V, X>(SelectorUnary<M, V, X> select) =>
    select is SelectorUnary<StoreEvaluator, V, X>;

bool isGenericSelectorBinary<M, V, X, Y>(SelectorBinary<M, V, X, Y> select) =>
    select is SelectorBinary<StoreEvaluator, V, X, Y>;
