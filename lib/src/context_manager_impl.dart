import 'dart:async';

import 'exceptions.dart';
import 'interfaces.dart';

class ContextManagerImpl implements ContextManager, ExecutionHelper {
  static final _possibleChangesKey = Object();

  final _cache = Expando<Set<Type>>();

  static Set<Type> _throwChangesNotFound() =>
      throw const WrongZoneApplyException();

  static Set<Type> _createEmptyChanges() => {};
  static Set<Type> _getEmptyChanges() => const {};

  @override
  bool get hasPossibleChanges =>
      _getPossibleChanges(Zone.current, orElse: _getEmptyChanges).isNotEmpty;

  @override
  bool hasPossibleChange(Type key) =>
      _getPossibleChanges(Zone.current, orElse: _getEmptyChanges).contains(key);

  @override
  void registerPossibleChange(Type key) {
    _getPossibleChanges(Zone.current).add(key);
  }

  @override
  void run(
    void Function() fn, {
    Zone source,
    ZoneSpecification zoneSpecification,
  }) {
    runZoned(fn, zoneSpecification: zoneSpecification, zoneValues: {
      _possibleChangesKey: source == null
          ? _createEmptyChanges()
          : _getPossibleChanges(source, orElse: _createEmptyChanges),
    });
  }

  Set<Type> _getPossibleChanges(
    Zone source, {
    Set<Type> Function() orElse = _throwChangesNotFound,
  }) {
    final cachedValue = _cache[source];
    if (cachedValue != null) return cachedValue;
    final Object value = source[_possibleChangesKey];
    _cache[source] = value != null && value is Set<Type> ? value : orElse();
    return _cache[source];
  }
}
