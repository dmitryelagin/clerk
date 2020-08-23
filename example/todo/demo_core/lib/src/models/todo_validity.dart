import '../models/todo_item.dart';
import '../models/todo_item_utils.dart';
import 'validity.dart';

class AddItemFailure extends Validity implements RetryableValidity {
  const AddItemFailure()
      : super('Failed to add item. Please, swipe right to try again.');
}

class ChangeItemFailure extends Validity
    implements RetryableValidity, RevertableValidity<TodoItem> {
  const ChangeItemFailure(this._previousLabel)
      : super('Failed to change item. Please, swipe right to try again.');

  final String _previousLabel;

  @override
  TodoItem revert(TodoItem currentValue) =>
      currentValue.update(label: _previousLabel, validity: Validity.valid);
}

class RemoveItemFailure extends Validity {
  const RemoveItemFailure()
      : super('Failed to remove item. Please, try again.');
}

class ToggleItemFailure extends Validity {
  const ToggleItemFailure()
      : super('Failed to toggle item. Please, try again.');
}

class ListLoadingFailure extends Validity {
  const ListLoadingFailure()
      : super('Failed to load the list of TODOs. Please, try again.');
}
