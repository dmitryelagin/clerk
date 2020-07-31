/// Command-based state manager.
///
/// Clerk can properly compose small logic parts to improve readability and
/// reusability of state management in your project.
library clerk;

export 'src/exceptions.dart';
export 'src/interfaces.dart'
    show
        StateAggregate,
        StoreAccessor,
        StoreExecutor,
        StoreManager,
        StoreReader;
export 'src/state.dart';
export 'src/state_reduced.dart';
export 'src/store.dart';
export 'src/store_settings.dart';
export 'src/types.dart'
    show
        Apply,
        ApplyUnary,
        ApplyBinary,
        CompareModels,
        GetAccumulator,
        GetModel,
        Read,
        ReadUnary,
        ReadBinary,
        Run,
        RunUnary,
        RunBinary;
