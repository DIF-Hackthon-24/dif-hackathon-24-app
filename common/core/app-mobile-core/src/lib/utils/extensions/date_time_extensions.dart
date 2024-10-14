import 'package:intl/intl.dart';

enum DateFormatTypes{
  ddMMyyy_FORMAT,
  ddMMMMyyyy_FORMAT,
  EEEEddMMMMyyyy_FORMAT,
  ddMMMyy_FORMAT
}

extension DateTimeFormateUtil on DateTime {
  /// Returns string like: `Sept 26, 2021`
  String toFullMonthTime() {
    return DateFormat('MMMM dd, yyyy').format(this);
  }

  /// Returns string like: `Sept 26, 2021`
  String toShortTime(bool? isArabic) {
    var day = DateFormat('dd ').format(this);
    var month = isArabic ?? false
        ? DateFormat('MMMM ', 'ar').format(this)
        : DateFormat('MMMM ').format(this);
    var year = isArabic ?? false ? DateFormat('yyyy،').format(this) : DateFormat('yyyy,').format(this);
    var finalDateFormat = day + month + year;
    return finalDateFormat;
  }

  String shortTime(bool? isArabic){
    return DateFormat('h:mm ').format(this) + (isArabic ?? false ? DateFormat('a','ar').format(this) : DateFormat('a').format(this));
  }

  /// Returns string like: `2021-05-25`
  String toShortDate() {
    return DateFormat('yyyy-MM-dd').format(this);
  }

  /// Returns a string like '2021-05-25 06:42:52
  String toShortDateTime() {
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(this);
  }

  /// Returns a string like '25/05/1999 06:42:52
  String toDateWithSlashAndTime({bool? isArabic}) {
    return (isArabic ?? false) ?
    DateFormat('dd/MM/yyyy، hh:mm a','ar').format(this) :
    DateFormat('dd/MM/yyyy, hh:mm a').format(this) ;
  }

  //9 July 2022 , 10:00 AM
  String toDateWithTime(bool? isArabic) {
    var day = DateFormat('dd ').format(this);
    var month = isArabic ?? false
        ? DateFormat('MMMM ', 'ar').format(this)
        : DateFormat('MMMM ').format(this);
    var year = isArabic ?? false ? DateFormat('yyyy،').format(this) : DateFormat('yyyy,').format(this);
    var finalDateFormat = day + month + year;
     var time =  DateFormat(' h:mm ').format(this) + (isArabic ?? false ? DateFormat('a','ar').format(this) : DateFormat('a').format(this));
    return finalDateFormat + time;
  }

  //9 July 2022
  String toDate(bool? isArabic) {
    var day = DateFormat('dd ').format(this);
    var month = isArabic ?? false
        ? DateFormat('MMMM ', 'ar').format(this)
        : DateFormat('MMMM ').format(this);
    var year = isArabic ?? false ? DateFormat('yyyy').format(this) : DateFormat('yyyy').format(this);
    var finalDateFormat = day + month + year;
    return finalDateFormat;
  }

  //Thursday
  String getFormattedDay(bool? isArabic) {
    return isArabic ?? false
        ? DateFormat('EEEE، ', 'ar').format(this)
        : DateFormat('EEEE, ').format(this);
  }

  /// Formats the date based on passed argument
  String toFormattedDate(String format, bool isArabic) {
    return DateFormat(format).format(this) + (isArabic ? DateFormat('a','ar').format(this) : DateFormat('a').format(this));
  }

  ///Our backend expecting UTC DateTime format
  ///it will format like this "yyyy-MM-ddTHH:mm:ss.SSSZ"
  String toBackendDateTimeFormat() {
    assert(isUtc, 'Backend side expecting utc date!!!');
    return toIso8601String();
  }

  /// This function will check if selected date is yesterday.
  /// If the difference is -1, then value will return true.
  bool isYesterday() {
    final now = DateTime.now();
    final _difference = DateTime(year, month, day).difference(DateTime(now.year, now.month, now.day)).inDays;
    return _difference == -1;
  }

  bool isToday() {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  bool isSameDate(DateTime date) {
    return year == date.year && month == date.month && day == date.day;
  }

  DateTime toOnlyDate() {
    return DateTime(year, month, day);
  }

  String getFormattedDate(bool? isArabic, DateFormatTypes enumType) {
    try {
      switch (enumType) {
        case DateFormatTypes.ddMMyyy_FORMAT:
          return isArabic ?? false
              ? DateFormat('yyyy/MM/dd').format(this)
              : DateFormat('dd/MM/yyyy').format(this);
        case DateFormatTypes.ddMMMyy_FORMAT:
          var day = DateFormat('dd ').format(this);
          var month = isArabic ?? false
              ? DateFormat('MMM ', 'ar').format(this)
              : DateFormat('MMM ').format(this);
          var year = DateFormat('yy').format(this);
          return day + month + year;
        case DateFormatTypes.ddMMMMyyyy_FORMAT:
          var day = DateFormat('dd ').format(this);
          var month = isArabic ?? false
              ? DateFormat('MMMM ', 'ar').format(this)
              : DateFormat('MMMM ').format(this);
          var year = DateFormat('yyyy').format(this);
          return day + month + year;
        case DateFormatTypes.EEEEddMMMMyyyy_FORMAT:
          var weekday = isArabic ?? false
              ? DateFormat('EEEE ', 'ar').format(this)
              : DateFormat('EEEE, ').format(this);
          var date = DateFormat('dd ').format(this);
          var month = isArabic ?? false
              ? DateFormat('MMMM ', 'ar').format(this)
              : DateFormat('MMMM ').format(this);
          var year = DateFormat('yyyy ').format(this);
          return weekday + date + month + year;
      }
    } catch (e) {
      return '';
    }
  }

  int dayDifferenceIncludingPartialDay(DateTime fromDateTime){
    int daysLeft = 0;
    int diffInMinutes = difference(fromDateTime).inMinutes;
    int wholeDays = (diffInMinutes ~/ (24 * 60)).abs();
    var remainingMinutes = diffInMinutes % (24 * 60);
    if (remainingMinutes != 0) {
      daysLeft = wholeDays + 1;
    } else {
      daysLeft = wholeDays;
    }
    if (diffInMinutes < 0) {
      return -daysLeft;
    } else {
      return daysLeft;
    }
  }

  DateTime get lastDayOfMonth =>
      month < 12 ? DateTime(year, month + 1, 0) : DateTime(year + 1, 1, 0);
}