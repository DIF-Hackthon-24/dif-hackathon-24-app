import 'package:core/utils/extensions/iterable_extensions.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('iterable extensions ...', () {
    test('iterable extensions mapIndexed ', () async {
      var names = <String>[
        'mahito',
        'itadori',
        'sukuna',
        'megumi',
      ];
      var elements = names.mapIndexed((element, index) => element);
      var order = names.mapIndexed((element, index) => index);
      expect(elements.first, 'mahito');
      expect(elements.length, 4);
      expect(order.length, 4);
    });

    test('iterable extensions forEachIndexed', () async {
      var names = <String>[
        'mahito',
        'itadori',
        'sukuna',
        'megumi',
      ];
      var list = [];
      var orders = [];
      names.forEachIndexed((element, index) {
        list.add(element);
        orders.add(index);
      });
      expect(list.first, 'mahito');
      expect(list.length, 4);
      expect(orders.length, 4);
    });
  });
}
