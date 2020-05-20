import '../../actions/change_item.dart';
import '../../actions/remove_item.dart';
import '../../actions/start_item_change.dart';
import '../../actions/stop_item_change.dart';
import '../../actions/toggle_item.dart';

abstract class TodoItemAction
    implements
        StartItemChange,
        StopItemChange,
        ChangeItem,
        ToggleItem,
        RemoveItem {}