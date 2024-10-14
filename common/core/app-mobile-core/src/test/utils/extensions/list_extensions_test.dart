import 'package:core/utils/extensions/list_extensions.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('isBlank list extensions ...', () {
    test('isBlank list extensions false case ...', () async {
      var list = [
        {'123': '123'},
        {'abc': 'cde'},
      ];
      expect(list.isBlank(), false);
    });

    test('isBlank list extensions true case...', () async {
      var list = [];
      expect(list.isBlank(), true);
    });
  });

  test('insertBetween function', () async {
    var list = ['mahito', 'genko', 'gojou', 'sasuke'];

    expect(list.insertBetween('naruto').length, 7);

    expect(list.insertBetween('naruto')[3], 'naruto');
  });

  group('firstOrNull function testing', () {
    test('firstOrNull function testing', () async {
      var list = ['1', '2', '3'];
      var actual = list.firstOrNull((element) => true);
      expect(actual, '1');
    });

    test('firstOrNull function testing', () async {
      var list = ['1', '2', '3'];
      var actual = list.firstOrNull((element) => false, orElse: () {
        return 'hello';
      });
      expect(actual, 'hello');
    });
  });
}
