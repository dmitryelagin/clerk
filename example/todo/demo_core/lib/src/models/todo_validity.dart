import '../models/todo_item.dart';
import '../models/todo_item_utils.dart';

class TodoValidity {
  const TodoValidity();

  String get message => '';
}

abstract class RevertableTodoValidity implements TodoValidity {
  TodoItem revert(TodoItem item);
}

class AddItemFailure implements TodoValidity {
  const AddItemFailure();

  @override
  String get message => 'Failed to add item. Please, try again.';
}

class ChangeItemFailure implements RevertableTodoValidity {
  const ChangeItemFailure(this._previousLabel);

  final String _previousLabel;

  @override
  String get message => 'Failed to change item. Please, try again.';

  @override
  TodoItem revert(TodoItem item) =>
      item.update(label: _previousLabel, validity: const TodoValidity());
}

class RemoveItemFailure implements TodoValidity {
  const RemoveItemFailure();

  @override
  String get message => 'Failed to remove item. Please, try again.';
}

class ToggleItemFailure implements TodoValidity {
  const ToggleItemFailure();

  @override
  String get message => 'Failed to toggle item. Please, try again.';
}
