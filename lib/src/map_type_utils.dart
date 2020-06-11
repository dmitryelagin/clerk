extension MapTypeUtils on Map<Type, Object> {
  T get<T>(Type key) {
    final value = this[key];
    return value is T ? value : null;
  }
}
