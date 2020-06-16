import 'package:mockito/mockito.dart';

class ReadMock<M, V> extends Mock {
  V call(M model);
}

class ReadUnaryMock<M, V, X> extends Mock {
  V call(M model, X x);
}

class ReadBinaryMock<M, V, X, Y> extends Mock {
  V call(M model, X x, Y y);
}
