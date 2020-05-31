import 'package:clerk/clerk.dart';

typedef ActionFactory = Action Function();
typedef ActionFactoryUnary<X> = Action Function(X);
typedef ActionFactoryBinary<X, Y> = Action Function(X, Y);

typedef Callback = void Function([Object, Object]);
typedef CallbackUnary<X> = void Function(X, [Object]);
typedef CallbackBinary<X, Y> = void Function(X, Y);
