import 'package:clerk/clerk.dart';

int getCounterMultipliedBy(int value, int multiplier) => value * multiplier;

int addToCounter(int value, int count) => value + count;

void incrementCounterBy(StoreManager store, int count) {
  store.writeUnary(addToCounter, count);
}

void main() {
  final store = Store((builder) => builder.add(StateReduced(0)));
  store.executor.executeUnary(incrementCounterBy, 5);
  final result = store.reader.readUnary(getCounterMultipliedBy, 2);
  // ignore: avoid_print
  print(result); // 10
}
