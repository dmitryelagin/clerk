extension MapUtils<K, V> on Map<K, V> {
  T get<T>(K key) {
    final value = this[key];
    return value is T ? value : null;
  }
}
