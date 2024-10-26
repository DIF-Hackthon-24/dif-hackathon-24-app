import 'package:core/base_classes/base_coordinator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:presentation/permission_request/state/permission_request_state.dart';
import 'package:presentation/permission_request/navigation_handler/permission_request_navigation_handler.dart';
import 'package:widget_library/loading_widget.dart';

class PermissionRequestCoordinator extends BaseCoordinator<PermissionRequestState> {
  final PermissionRequestNavigationHandler navigationHandler;

  PermissionRequestCoordinator({
    required this.navigationHandler,
}) : super(PermissionRequestState(getPermissionRequestData: ''));

  Future<void> initialize(BuildContext context) async {
  }

  void navigateToSplash() {
    navigationHandler.navigateToSplash();
  }

  // Future<PermissionRequestState> fetchPermissionRequestData() async {
  //   // Simulate an API call
  //   await Future.delayed(Duration(seconds: 2));
  //   return PermissionRequestState(getPermissionRequestData: 'Sample request details');
  // }

  Future<void> grantPermission(BuildContext context, PermissionRequestState state) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => LoadingWidget(),
    );

    // Simulate an API call
    // await Future.delayed(Duration(seconds: 2));

    Navigator.pop(context); // Close the loading dialog

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Permission Granted'),
        content: Text('Details: ${state.getPermissionRequestData}'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void denyPermission(BuildContext context) {
    Navigator.pop(context); // Close the current page
  }
}