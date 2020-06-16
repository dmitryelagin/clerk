import 'package:clerk/clerk.dart';

Execute executeWrite<A, V>(Write<A, V> fn) {
  return (store) {
    store.write(fn);
  };
}
