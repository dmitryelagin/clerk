import 'dart:async';

import 'exceptions.dart';
import 'interfaces.dart';

class ContextManagerImpl implements ContextManager, ExecutionHelper {
  const ContextManagerImpl();

  static final _possibleChangesKey = Object();

  static Set<Type> _getPossibleChanges({
    Zone source,
    Set<Type> Function() orElse = _throwChangesNotFound,
  }) {
    final Object changes = source != null ? source[_possibleChangesKey] : null;
    return changes != null && changes is Set<Type> ? changes : orElse();
  }

  static Set<Type> _throwChangesNotFound() =>
      throw const WrongZoneApplyException();

  static Set<Type> _createEmptyChanges() => {};
  static Set<Type> _getEmptyChanges() => const {};

  @override
  bool get hasPossibleChanges =>
      _getPossibleChanges(source: Zone.current, orElse: _getEmptyChanges)
          .isNotEmpty;

  @override
  bool hasPossibleChange(Type key) =>
      _getPossibleChanges(source: Zone.current, orElse: _getEmptyChanges)
          .contains(key);

  @override
  void registerPossibleChange(Type key) {
    _getPossibleChanges(source: Zone.current).add(key);
  }

  @override
  void run(void Function() fn, {Zone source, ZoneSpecification specification}) {
    runZoned(fn, zoneSpecification: specification, zoneValues: {
      _possibleChangesKey:
          _getPossibleChanges(source: source, orElse: _createEmptyChanges),
    });
  }
}
