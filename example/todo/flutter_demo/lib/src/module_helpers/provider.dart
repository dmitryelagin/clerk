abstract class Provider<T extends Object> {
  bool get isLazy;
  T getInstance();
  void reset();
}
