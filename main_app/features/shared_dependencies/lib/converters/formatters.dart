import 'package:core/utils/extensions/string_extensions.dart';

class StringFormatters {
  static const String space = ' ';
  static String mobileNoFormatter(String data, bool isArabic) {
    //Only support UAE formatting.
    if (data.isNotEmpty) {
      final length = data.length;
      if (!isArabic) {
        return '+' +
            data.substring(0, length - 9) +
            ' ' +
            data.substring(length - 9, length);
      } else {
        return data.substring(length - 9, length) +
            ' ' +
            data.substring(0, length - 9) +
            '+';
      }
    }
    return data;
  }

  static String getFirstName(bool isRTL, String? fullName) {
    List<String> names = fullName?.split(space) ?? [];
    if (isRTL) {
      if (names.isEmpty) {
        return '';
      } else {
        return names.length <= 2
            ? fullName ?? ''
            : '${names.elementAt(0)} ${names.elementAt(1)}';
      }
    } else {
      if (names.isEmpty) {
        return '';
      } else {
        return names.first;
      }
    }
  }

  static String emiratesIdFormatter(String data) {
    if (data.isNotEmpty) {
      return data.substring(0, 3) +
          '-' +
          data.substring(3, 7) +
          '-' +
          data.substring(7, 14) +
          '-' +
          data.substring(14);
    }
    return data;
  }

  static String applicationNumberFormatter(String? applicationNumber) {
    if (applicationNumber.isNotBlank() && applicationNumber?.length == 10) {
      var description = applicationNumber!.split('');
      description.insert(3, '-');
      description.insert(8, '-');
      return description.join();
    }
    return applicationNumber ?? '';
  }

  static String getNumberOfDays(int seconds) {
    return ((seconds ~/ 3600) ~/ 24).toString();
  }

  static String getMinutes(int seconds) {
    return (seconds ~/ 60).toString();
  }

  static int getNumberOfHoursInInteger(int seconds){
    return (seconds ~/ 3600).toInt();
  }
}
