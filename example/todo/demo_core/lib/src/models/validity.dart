class Validity {
  const Validity(this.message);

  static const valid = Validity('');

  final String message;

  bool get isValid => message.isEmpty;
}

abstract class RetryableValidity implements Validity {}

abstract class RevertableValidity<T> implements Validity {
  T revert(T currentValue);
}
