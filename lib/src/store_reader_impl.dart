import 'interfaces_public.dart';
import 'types_public.dart';

class StoreReaderImpl implements StoreReader {
  const StoreReaderImpl(this._innerReader);

  final StoreReader _innerReader;

  @override
  V read<M, V>(Read<M, V> fn) {
    return _innerReader.read(fn);
  }

  @override
  V readUnary<M, V, X>(ReadUnary<M, V, X> fn, X x) {
    return _innerReader.readUnary(fn, x);
  }

  @override
  V readBinary<M, V, X, Y>(ReadBinary<M, V, X, Y> fn, X x, Y y) {
    return _innerReader.readBinary(fn, x, y);
  }
}
