import 'package:clerk/clerk.dart';

class Counter {
  int value = 0;

  void add(int count) {
    value += count;
  }
}

int getCounterMultipliedBy(int value, int multiplier) => value * multiplier;

void addToCounter(Counter counter, int count) {
  counter.add(count);
}

void main() {
  final store = Store((builder) {
    builder.add(State<int, Counter>(Counter(), getModel: (acc) => acc.value));
  }, StoreSettings.standard);
  store.executor.applyUnary(addToCounter, 5);
  final result = store.reader.readUnary(getCounterMultipliedBy, 2);
  // ignore: avoid_print
  print(result); // 10
}
