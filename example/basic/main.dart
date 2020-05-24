import 'package:clerk/clerk.dart';

class AppModel {
  const AppModel(this.counter);

  final int counter;

  static bool areEqual(AppModel a, AppModel b) => a.counter == b.counter;
}

int getMultipliedCounter(AppModel model, int multiplier) =>
    model.counter * multiplier;

AppModel addToCounter(AppModel model, int count) =>
    AppModel(model.counter + count);

Action incrementCounterBy(int count) =>
    Action(executeUnaryWriter(addToCounter, count));

void main() {
  final store = Store()
    ..composer.add(ReducedState(const AppModel(0), AppModel.areEqual))
    ..executor.execute(incrementCounterBy(5));
  final result = store.evaluator.evaluateUnary(getMultipliedCounter, 2);
  // ignore: avoid_print
  print(result); // 10
}
