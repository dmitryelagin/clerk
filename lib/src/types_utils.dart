import 'interfaces.dart';
import 'types.dart';

extension ReadUtils<M, V> on Read<M, V> {
  bool get isGeneric => this is Read<StoreReader, V>;
}

extension ReadUnaryUtils<M, V, X> on ReadUnary<M, V, X> {
  bool get isGeneric => this is ReadUnary<StoreReader, V, X>;
}

extension ReadBinaryUtils<M, V, X, Y> on ReadBinary<M, V, X, Y> {
  bool get isGeneric => this is ReadBinary<StoreReader, V, X, Y>;
}

extension ApplyUtils<A> on Apply<A> {
  bool get isExecution => this is Apply<StoreManager>;
}

extension ApplyUnaryUtils<A, X> on ApplyUnary<A, X> {
  bool get isExecution => this is ApplyUnary<StoreManager, X>;
}

extension ApplyBinaryUtils<A, X, Y> on ApplyBinary<A, X, Y> {
  bool get isExecution => this is ApplyBinary<StoreManager, X, Y>;
}
