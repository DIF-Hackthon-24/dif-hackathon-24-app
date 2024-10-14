import 'package:core/utils/extensions/date_time_extensions.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  setUpAll(
    () {
      initializeDateFormatting('ar', null);
    },
  );

  group('Date time extensions testing', () {
    test('toFullMonthTime date time extension', () async {
      final date = DateTime(2018, 10, 10);
      expect(date.toFullMonthTime(), 'October 10, 2018');
    });

    test('toShortTime date time extension', () async {
      final date = DateTime(2018, 10, 10);
      expect(date.toShortTime(false), 'Oct 10, 2018');
    });

    test('toShortDate date time extension', () async {
      final date = DateTime(2018, 10, 10);
      expect(date.toShortDate(), '2018-10-10');
    });

    test('toShortDateTime date time extension', () async {
      final date = DateTime(2018, 10, 10, 18, 30, 25);
      expect(date.toShortDateTime(), '2018-10-10 18:30:25');
    });

    test('toFormattedDate date time extension', () async {
      final date = DateTime(2019, 10, 10);
      final format = 'dd-MM-yyyy';
      expect(date.toFormattedDate(format,false), '10-10-2019');
    });

    test('toFormattedDate date time extension', () async {
      final date = DateTime(2019, 10, 10);
      final format = 'yyyy-dd-MM';
      expect(date.toFormattedDate(format,false), '2019-10-10');
    });

    test('toBackendDateTimeFormat date time extension', () async {
      final date = DateTime.utc(1944, 6, 6);
      expect(date.toBackendDateTimeFormat(), '1944-06-06T00:00:00.000Z');
    });

    test('toBackendDateTimeFormat date time extension', () async {
      final date = DateTime.utc(1944, 6, 6, 18, 30, 05, 06);
      expect(date.toBackendDateTimeFormat(), '1944-06-06T18:30:05.006Z');
    });

    test('isYesterday date time extension true case', () async {
      var now = DateTime.now();
      final date = DateTime(now.year, now.month, now.day - 1);
      expect(date.isYesterday(), true);
    });

    test('isYesterday date time extension false case', () async {
      var now = DateTime.now();
      final date = DateTime(now.year, now.month, now.day);
      expect(date.isYesterday(), false);
    });

    test('isToday date time extension true case', () async {
      var now = DateTime.now();
      final date = DateTime(now.year, now.month, now.day);
      expect(date.isToday(), true);
    });

    test('isToday date time extension false case', () async {
      var now = DateTime.now();
      final date = DateTime(now.year, now.month, now.day - 1);
      expect(date.isToday(), false);
    });

    test('toOnlyDate date time extension testing', () async {
      final date = DateTime(2021, 11, 14);
      expect(date.toOnlyDate().day, 14);
    });

    test('toOnlyDate date time extension testing', () async {
      final date = DateTime(2021, 11, 14);
      expect(date.toOnlyDate().month, 11);
    });

    test('toOnlyDate date time extension testing', () async {
      final date = DateTime(2021, 11, 14);
      expect(date.toOnlyDate().year, 2021);
    });

    test(
      'getFormattedDate date time extension testing ddMMyyy_FORMAT',
      () async {
        final date = DateTime(2021, 11, 14);
        expect(
          date.getFormattedDate(false, DateFormatTypes.ddMMyyy_FORMAT),
          '14/11/2021',
        );
      },
    );

    test(
      'getFormattedDate date time extension testing ddMMyyy_FORMAT arabic',
      () async {
        final date = DateTime(2021, 11, 14);
        expect(
          date.getFormattedDate(true, DateFormatTypes.ddMMyyy_FORMAT),
          '2021/11/14',
        );
      },
    );

    test(
      'getFormattedDate date time extension testing ddMMMMyyyy_FORMAT',
      () async {
        final date = DateTime(2021, 11, 14);
        expect(
          date.getFormattedDate(false, DateFormatTypes.ddMMMMyyyy_FORMAT),
          '14 November 2021',
        );
      },
    );

    test(
      'getFormattedDate date time extension testing ddMMMMyyyy_FORMAT arabic',
      () async {
        final date = DateTime(2021, 11, 14);
        expect(
          date.getFormattedDate(true, DateFormatTypes.ddMMMMyyyy_FORMAT),
          '14 نوفمبر 2021',
        );
      },
    );

    test(
      'getFormattedDate date time extension testing EEEEddMMMMyyyy_FORMAT',
      () async {
        final date = DateTime(2021, 11, 14);
        expect(
          date.getFormattedDate(false, DateFormatTypes.EEEEddMMMMyyyy_FORMAT),
          'Sunday, 14 November 2021 ',
        );
      },
    );

    test(
      'getFormattedDate date time extension testing EEEEddMMMMyyyy_FORMAT arabic',
      () async {
        final date = DateTime(2021, 11, 14);
        expect(
          date.getFormattedDate(true, DateFormatTypes.EEEEddMMMMyyyy_FORMAT),
          'الأحد 14 نوفمبر 2021 ',
        );
      },
    );

    test('toDateWithTime date time extension testing ', () async {
      final date = DateTime(2021, 11, 14);
      expect(date.toDateWithTime(false), '14 November 2021, 12:00 AM');
    });

    test('toDateWithTime date time extension testing ', () async {
      final date = DateTime(2021, 11, 14);
      expect(date.toDateWithTime(true), '14 نوفمبر 2021، 12:00 ص');
    });
  });
}
