class RemainingTimeConverter {
  String getRemainingTime({
    required String? reservedDate,
    required int? maxTime,
    required String? daysText,
    required String? dayText,
    required String? minutesText,
    bool? isRtl,
  }) {
    if (reservedDate == null || maxTime == null) {
      return '0H 0M';
    }

    DateTime reservedDateTime = DateTime.parse(reservedDate);

    DateTime current = DateTime.now().toUtc();

    Duration durDiff = current.difference(reservedDateTime);

    Duration maxDuration = Duration(hours: maxTime);

    final remainingTime = maxDuration - durDiff;
    if(remainingTime.isNegative){
      return '0H 0M';
    }
    else if (remainingTime.inHours < 24) {
      String twoDigits(int n) => n.toString().padLeft(2, "");

      String twoDigitMinutes = twoDigits(remainingTime.inMinutes.remainder(60));

      return "${twoDigits(remainingTime.inHours)}H ${twoDigitMinutes}M";
    }
    else if(remainingTime.inHours >=24 && remainingTime.inHours<48){
      return '${remainingTime.inDays} $dayText';
    }
    else {
      return '${remainingTime.inDays} $daysText';
    }
  }

  String getRemainingTimeInDays({
    required int updatedTS,
    required int maxDays,
  }) {
    if (updatedTS == 0) {
      return '0';
    }

    DateTime reservedDateTime = DateTime.fromMillisecondsSinceEpoch(updatedTS);

    DateTime current = DateTime.now();

    Duration durDiff = current.difference(reservedDateTime);

    Duration maxDuration = Duration(days: maxDays);

    final remainingTime = maxDuration - durDiff;
    if (remainingTime.isNegative) {
      return '0';
    } else {
      return '${remainingTime.inDays}';
    }
  }

  bool hasCrossedNumberOfDays({
    required int? updatedTS,
    required int maxDays,
  }) {
    if (updatedTS == null) {
      return true;
    }

    DateTime reservedDateTime = DateTime.fromMillisecondsSinceEpoch(updatedTS);

    DateTime current = DateTime.now();

    Duration durDiff = current.difference(reservedDateTime);

    Duration maxDuration = Duration(days: maxDays);

    final remainingTime = maxDuration - durDiff;
    if (remainingTime.isNegative) {
      return true;
    } else {
      return false;
    }
  }

  String getRemainingTimePlotConfirmation({
    required String? reservedDate,
    required int? maxTime,
    required String? daysText,
    required bool isRtl,
    required String defaultTimeText,
    required String hoursText,
    required String minText,
    required String? dayText,
  }) {
    if (reservedDate == null || maxTime == null) {
      return defaultTimeText;
    }

    DateTime reservedDateTime = DateTime.parse(reservedDate);

    DateTime current = DateTime.now().toUtc();

    Duration durDiff = current.difference(reservedDateTime);

    Duration maxDuration = Duration(hours: maxTime);

    final remainingTime = maxDuration - durDiff;
    if(remainingTime.isNegative){
      return defaultTimeText;
    }
    else if (remainingTime.inHours < 24) {
      String twoDigits(int n) => n.toString().padLeft(2, "");

      String twoDigitMinutes = twoDigits(remainingTime.inMinutes.remainder(60));

      return isRtl
          ? "${twoDigits(remainingTime.inHours)} $hoursText ${twoDigitMinutes} $minText"
          : "${twoDigits(remainingTime.inHours)}$hoursText ${twoDigitMinutes}$minText";
    }
    else if(remainingTime.inHours >= 24 && remainingTime.inHours < 48){
      return '${remainingTime.inDays} $dayText';
    }
    else {
      return '${remainingTime.inDays} $daysText';
    }
  }

  String getRemainingTimeLandExchange(    
    {required String? reservedDate,
    required int? maxTime,
    required String? daysText,
    required String? minutesText,
    bool? isRtl,
    }){

    if (reservedDate == null || maxTime == null) {
      return '0H 0M';
    }

    DateTime reservedDateTime = DateTime.parse(reservedDate);

    DateTime current = DateTime.now();

    Duration durDiff = current.difference(reservedDateTime);

      
      Duration maxDuration = Duration(minutes: maxTime);

      final remainingTime = maxDuration - durDiff;
      if(remainingTime.isNegative){
      return '0 $minutesText';
      }
      else {
      return isRtl == true ? ' $minutesText ${remainingTime.inMinutes}' : '${remainingTime.inMinutes} $minutesText';
      }
  }
}
