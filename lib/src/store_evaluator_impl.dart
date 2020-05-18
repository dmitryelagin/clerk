import 'public_interfaces.dart';
import 'types.dart';

class StoreEvaluatorImpl implements StoreEvaluator {
  StoreEvaluatorImpl(this._innerEvaluator);

  final StoreEvaluator _innerEvaluator;

  @override
  V evaluate<M, V>(Selector<M, V> select) => _innerEvaluator.evaluate(select);

  @override
  V evaluateUnary<M, V, X>(SelectorUnary<M, V, X> select, X x) =>
      _innerEvaluator.evaluateUnary(select, x);

  @override
  V evaluateBinary<M, V, X, Y>(SelectorBinary<M, V, X, Y> select, X x, Y y) =>
      _innerEvaluator.evaluateBinary(select, x, y);
}
