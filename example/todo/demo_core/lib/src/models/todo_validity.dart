class TodoValidity {
  const TodoValidity();

  String get message => '';
}

class AddItemFailure implements TodoValidity {
  const AddItemFailure();

  @override
  String get message => 'Failed to add item. Please, try again.';
}

class ChangeItemFailure implements TodoValidity {
  const ChangeItemFailure();

  @override
  String get message => 'Failed to change item. Please, try again.';
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
