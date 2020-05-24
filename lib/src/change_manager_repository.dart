import 'change_manager.dart';
import 'map_utils.dart';

class ChangeManagerRepository {
  final _managers = <Type, ChangeManager>{};

  bool get hasChanges => _managers.values.any(_hasChange);
  bool get hasDeferredChanges => _managers.values.any(_hasDeferredChange);

  static bool _hasChange(ChangeManager manager) => manager.hasChange;

  static bool _hasDeferredChange(ChangeManager manager) =>
      manager.hasDeferredChange;

  ChangeManager<T> get<T>() => _managers.get(T);

  void add<T>(Stream<T> changes) {
    _managers[T] = ChangeManager<T>(changes);
  }

  void remove<T>() {
    _managers[T]?.teardown();
    _managers.remove(T);
  }

  void clear() {
    for (final manager in _managers.values) {
      manager.teardown();
    }
    _managers.clear();
  }

  void sinkChanges() {
    for (final manager in _managers.values) {
      manager.sinkChange();
    }
  }

  void sinkDeferredChanges() {
    for (final manager in _managers.values) {
      manager.sinkDeferredChange();
    }
  }
}
