class NotificationConstants{
  static const profileGenerated = 'BASIC_PROFILE';
  static const applicationSubmitted = 'SUBMITTED';
  static const applicationINVSNT = 'INVSNT';
  static const parked = 'PARKED';
  static const applicationINV_SENT = 'INV_SENT';
  static const rejected_application = 'REJECT';
  static const cancel_application = 'CANCEL';
  static const profileGeneratedUpdateStreamKey = {'profileGeneratedNotificationListener':'refresh'};
  static const refreshActiveApplicationsStreamKey = {'refreshActiveApplicationsNotificationListener':'refresh'};
  static const isSilentKey = 'isSilent';
  static const typeKey = 'type';
  static Map<String, dynamic> notificationNotifierDataStream(
    Map<String, dynamic> data,
  ) {
    return {
      'did_received_notification': 'refresh',
      'dataNotifierParamValues': data,
    };
  }
}