import 'dart:async';

class ChangeManager<T extends Object> {
  ChangeManager(Stream<T> changes) {
    _subscription = changes.listen((model) {
      _change = _deferredChange = model;
    }, onDone: teardown);
  }

  final _modelChange = StreamController<T>.broadcast(sync: true);
  final _afterModelChanges = StreamController<T>.broadcast(sync: true);

  StreamSubscription<T> _subscription;

  T _change;
  T _deferredChange;

  bool get hasChange => _change != null;
  bool get hasDeferredChange => _deferredChange != null;

  Stream<T> get onModelChange => _modelChange.stream;
  Stream<T> get onAfterModelChanges => _afterModelChanges.stream;

  void sinkChange() {
    if (!hasChange) return;
    _modelChange.add(_change);
    _change = null;
  }

  void sinkDeferredChange() {
    if (!hasDeferredChange) return;
    _afterModelChanges.add(_deferredChange);
    _deferredChange = null;
  }

  void teardown() {
    _subscription?.cancel();
    _modelChange.close();
    _afterModelChanges.close();
  }
}
