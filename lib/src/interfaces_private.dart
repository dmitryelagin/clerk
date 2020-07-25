import 'dart:async';

import 'types_public.dart';

abstract class StateManager<M extends Object, A extends Object> {
  Stream<M> get onChange;
  Stream<M> get onAfterChanges;
  V read<V>(Read<M, V> fn);
  V readUnary<V, X>(ReadUnary<M, V, X> fn, X x);
  V readBinary<V, X, Y>(ReadBinary<M, V, X, Y> fn, X x, Y y);
  void write(Write<A> fn);
  void writeUnary<X>(WriteUnary<A, X> fn, X x);
  void writeBinary<X, Y>(WriteBinary<A, X, Y> fn, X x, Y y);
}
