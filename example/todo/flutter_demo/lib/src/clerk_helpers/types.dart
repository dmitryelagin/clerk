import 'package:clerk/clerk.dart';

typedef ActionsFactory = Iterable<Action> Function();
typedef ActionsFactoryUnary<X> = Iterable<Action> Function(X);
typedef ActionsFactoryBinary<X, Y> = Iterable<Action> Function(X, Y);

typedef Callback = void Function([Object, Object]);
typedef CallbackUnary<X> = void Function(X, [Object]);
typedef CallbackBinary<X, Y> = void Function(X, Y);
