import 'state_controller.dart';

extension StateControllerMapUtils on Map<Type, StateController> {
  Map<Type, Object?> extractModels() => map(_getTypeModelEntry);

  MapEntry<Type, Object?> _getTypeModelEntry(Type key, StateController value) =>
      MapEntry(key, value.model);
}

extension StateControllerIterableUtils on Iterable<StateController> {
  bool get hasChanges => any(_hasChange);
  bool get hasDeferredChanges => any(_hasDeferredChange);

  void checkChanges() {
    for (final controller in this) {
      controller.checkChange();
    }
  }

  void sinkChanges() {
    for (final controller in this) {
      controller.sinkChange();
    }
  }

  void sinkDeferredChanges() {
    for (final controller in this) {
      controller.sinkDeferredChange();
    }
  }

  Future<void> teardown() async {
    await Future.wait(map(_teardownController));
  }

  bool _hasChange(StateController controller) => controller.hasChange;

  bool _hasDeferredChange(StateController controller) =>
      controller.hasDeferredChange;

  Future<void> _teardownController(StateController controller) =>
      controller.teardown();
}
