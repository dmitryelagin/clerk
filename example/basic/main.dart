import 'package:clerk/clerk.dart';

int getMultipliedCounter(int value, int multiplier) => value * multiplier;

int addToCounter(int value, int count) => value + count;

Action incrementCounterBy(int count) =>
    Action((store) => store.writeUnary(addToCounter, count));

void main() {
  final store = Store((builder) => builder.add(StateReduced(0)));
  store.executor.execute(incrementCounterBy(5));
  final result = store.reader.readUnary(getMultipliedCounter, 2);
  // ignore: avoid_print
  print(result); // 10
}
