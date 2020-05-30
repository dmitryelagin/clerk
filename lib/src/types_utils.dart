import 'interfaces_public.dart';
import 'types_public.dart';

extension SelectorUtils<M, V> on Selector<M, V> {
  bool get isGeneric => this is Selector<StoreEvaluator, V>;
}

extension SelectorUnaryUtils<M, V, X> on SelectorUnary<M, V, X> {
  bool get isGeneric => this is SelectorUnary<StoreEvaluator, V, X>;
}

extension SelectorBinaryUtils<M, V, X, Y> on SelectorBinary<M, V, X, Y> {
  bool get isGeneric => this is SelectorBinary<StoreEvaluator, V, X, Y>;
}
