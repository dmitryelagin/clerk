import 'package:clerk/clerk.dart';
import 'package:clerk/src/types_utils.dart';
import 'package:test/test.dart';

void main() {
  group('[Read] function types:', () {
    test('can determine generic function subset from [Read]', () {
      expect(_getRead<StoreReader>().isGeneric, true);
      expect(_getRead<dynamic>().isGeneric, true);
      expect(_getRead<Object>().isGeneric, true);
      expect(_getRead<void>().isGeneric, true);
      expect(_getRead<_StoreCustomReader>().isGeneric, false);
      expect(_getRead<StoreManager>().isGeneric, false);
      expect(_getRead<String>().isGeneric, false);
    });

    test('can determine generic function subset from [ReadUnary]', () {
      expect(_getReadUnary<StoreReader>().isGeneric, true);
      expect(_getReadUnary<dynamic>().isGeneric, true);
      expect(_getReadUnary<Object>().isGeneric, true);
      expect(_getReadUnary<void>().isGeneric, true);
      expect(_getReadUnary<_StoreCustomReader>().isGeneric, false);
      expect(_getReadUnary<StoreManager>().isGeneric, false);
      expect(_getReadUnary<String>().isGeneric, false);
    });

    test('can determine generic function subset from [ReadBinary]', () {
      expect(_getReadBinary<StoreReader>().isGeneric, true);
      expect(_getReadBinary<dynamic>().isGeneric, true);
      expect(_getReadBinary<Object>().isGeneric, true);
      expect(_getReadBinary<void>().isGeneric, true);
      expect(_getReadBinary<_StoreCustomReader>().isGeneric, false);
      expect(_getReadBinary<StoreManager>().isGeneric, false);
      expect(_getReadBinary<String>().isGeneric, false);
    });
  });
}

abstract class _StoreCustomReader extends StoreReader {}

Read<M, Object> _getRead<M>() => (model) => null!;

ReadUnary<M, Object, Object> _getReadUnary<M>() => (model, x) => null!;

ReadBinary<M, Object, Object, Object> _getReadBinary<M>() =>
    (model, x, y) => null!;
