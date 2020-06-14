import 'interfaces_public.dart';
import 'types_public.dart';

extension ReadUtils<M, V> on Read<M, V> {
  bool get isGeneric => this is Read<StoreReader, V>;
}

extension ReadUnaryUtils<M, V, X> on ReadUnary<M, V, X> {
  bool get isGeneric => this is ReadUnary<StoreReader, V, X>;
}

extension ReadBinaryUtils<M, V, X, Y> on ReadBinary<M, V, X, Y> {
  bool get isGeneric => this is ReadBinary<StoreReader, V, X, Y>;
}
