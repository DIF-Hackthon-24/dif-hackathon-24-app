class StreamConstants{
  static const applicationUpdatedStream = {'dashboard_update': 'refresh'};
  static Map<String,dynamic> applicationUpdatedDashboardOnlyStream(String value){
    return {
    'dashboard_update': 'refresh',
    'dataNotifierParamValues': value,
    };
  }
  static Map<String,dynamic> discardApiCalled(bool value){
    return {
    'dashboard_update': 'refresh',
    'dataNotifierParamValues': value,
    };
  }
  static const applicationUpdatedStreamKey = 'dashboard_update';
  static const profileGeneratedNotificationListener = 'profileGeneratedNotificationListener';
  static  Map<String,dynamic> profileGeneratedNotificationListenerStreamKey(String val){
     return {
        'profileGeneratedNotificationListener':'refresh',
        'dataNotifierParamValues': val
     };
  }
  static const refreshActiveApplicationsStreamKey = 'refreshActiveApplicationsNotificationListener';
  static const notificationReadStreamKey = 'notification_read';
  static const notificationReadStream = {'notification_read': 'refresh'};
  
  static const onTapNotificationStreamKey = 'on_tap_notification';
  static Map<String,dynamic> onTapNotificationStream(String value){
     return {
      'on_tap_notification': 'refresh',
      'dataNotifierParamValues': value,
    };
  }
  static const didReceivedNotificationStreamKey = 'did_received_notification';

  static const updateNotificationBadgeOnHomeScreenStreamKey = 'update_notification_badge_on_home';
  static const updateNotificationBadgeOnHomeScreenStream = {'update_notification_badge_on_home': 'refresh'};
  
  static const listOrMapViewStreamKey = 'list_or_map_wiew';
  static Map<String, dynamic> onListOrMapViewStream(String value) {
    return {
      'list_or_map_wiew': 'refresh',
      'dataNotifierParamValues': value,
    };
  }

  static const onEditReviewApplicationStreamKey = 'on_edit_review_application';
  static Map<String, dynamic> onEditReviewApplicationStream(Map<String,dynamic> arcgs) {
    return {
      'on_edit_review_application': 'refresh',
      'dataNotifierParamValues': arcgs,
    };
  }
  static const onEditReviewUpdateApplicationStreamKey = 'on_edit_review_update_application';
  static Map<String, dynamic> onEditReviewUpdateApplicationStream(Map<String,dynamic> arcgs) {
    return {
      'on_edit_review_update_application': 'refresh',
      'dataNotifierParamValues': arcgs,
    };
  }


  static const onApplicationCreationStreamKey = 'on_application_creation_refresh';
  static const onApplicationCreationStream = {
      'on_application_creation_refresh': 'refresh',
  };

  static const onChangeBottomNavigationBarStreamKey = 'on_change_bottom_navigation_bar';
  static Map<String,dynamic> onChangeBottomNavigationBarStream(int index){
     return {
      'on_change_bottom_navigation_bar': 'refresh',
      'dataNotifierParamValues': index,
    };
  }

  static const recalculateEligibility = 'recalculate';
}