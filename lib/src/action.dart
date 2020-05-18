import 'public_interfaces.dart';
import 'types.dart';

/// A command that is allowed to interact with store via [StoreManager].
///
/// [Action] is command - an object that can execute an operation and is
/// provided with all the data it needs to work. [Action] is allowed to
/// access store and is the only valid way to write data to states.
class Action {
  /// Creates basic [Action] with provided operation.
  ///
  /// All the data for operation to execute should be saved in
  /// callback's clojure.
  const Action(this._execute);

  final ActionOperation _execute;

  /// Execute operation saved in command.
  ///
  /// This method will be called by store during execution.
  void execute(StoreManager store) {
    _execute(store);
  }
}
