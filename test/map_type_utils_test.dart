import 'package:clerk/src/map_type_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Map<Type, Object> utils:', () {
    test('get method returns properly typed value', () {
      expect({Object: #arg}.get<Symbol>(Object), #arg);
      expect({Object: #arg}.get<String>(Object), null);
      expect({Symbol: #arg}.get<Object>(Symbol), #arg);

      final custom = _Custom();
      expect({_Custom: custom}.get<_Custom>(_Custom), custom);
      expect({_Custom: custom}.get<_ExtendedCustom>(_Custom), null);
      expect({_ExtendedCustom: custom}.get<_Custom>(_ExtendedCustom), custom);
      expect({_ExtendedCustom: custom}.get<_ExtendedCustom>(_Custom), null);
    });
  });
}

class _Custom {}

class _ExtendedCustom extends _Custom {}
