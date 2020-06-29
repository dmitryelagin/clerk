import 'package:clerk/clerk.dart';

typedef ExecuteFactory = Execute Function();
typedef ExecuteFactoryUnary<X> = Execute Function(X);
typedef ExecuteFactoryBinary<X, Y> = Execute Function(X, Y);

typedef Callback = void Function([Object, Object]);
typedef CallbackUnary<X> = void Function(X, [Object]);
typedef CallbackBinary<X, Y> = void Function(X, Y);
