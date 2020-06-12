import 'state_controller.dart';

extension StateControllerMapUtils on Map<Type, StateController> {
  Map<Type, Object> extractModels() => map(_getTypeModelEntry);

  MapEntry<Type, Object> _getTypeModelEntry(Type key, StateController value) =>
      MapEntry(key, value.model);
}

extension StateControllerIterableUtils on Iterable<StateController> {
  bool get hasChanges => any(_hasChange);
  bool get hasDeferredChanges => any(_hasDeferredChange);

  void endTransanctions() {
    for (final controller in this) {
      controller.endTransanction();
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

  void teardown() {
    for (final controller in this) {
      controller.teardown();
    }
  }

  bool _hasChange(StateController controller) => controller.hasChange;

  bool _hasDeferredChange(StateController controller) =>
      controller.hasDeferredChange;
}
