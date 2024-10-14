import 'package:core/utils/extensions/object_extensions.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('object extensions testing', () {
    test('object extensions isEmptyOrNull testing false case', () async {
      var list = <dynamic>['1', '2', '3'];
      expect(list.isEmptyOrNull, false);
    });

    test('object extensions isEmptyOrNull testing true case', () async {
      var list = <dynamic>[];
      expect(list.isEmptyOrNull, true);
    });
  });

  group('isNotEmptyOrNull extensions', () {
    test('object extensions isEmptyOrNull testing false case', () async {
      var list = <dynamic>[];
      expect(list.isNotEmptyOrNull, false);
    });

    test('object extensions isEmptyOrNull testing false case', () async {
      var list = {'123': '1234'};
      expect(list.isNotEmptyOrNull, true);
    });
    test('object extensions isEmptyOrNull testing true case', () async {
      var list = <dynamic>['123', 'asdad', 'asv'];
      expect(list.isNotEmptyOrNull, true);
    });
  });
}
