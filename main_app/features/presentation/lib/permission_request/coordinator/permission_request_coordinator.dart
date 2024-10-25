// permission_request_coordinator.dart
import 'package:flutter/material.dart';
import 'package:presentation/permission_request/state/permission_request_state.dart';
import 'package:widget_library/loading_widget.dart';

class PermissionRequestCoordinator {
  Future<PermissionRequestState> fetchPermissionRequestData() async {
    // Simulate an API call
    await Future.delayed(Duration(seconds: 2));
    return PermissionRequestState(requestDetails: 'Sample request details');
  }

  Future<void> grantPermission(BuildContext context, PermissionRequestState state) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => LoadingWidget(),
    );

    // Simulate an API call
    await Future.delayed(Duration(seconds: 2));

    Navigator.pop(context); // Close the loading dialog

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Permission Granted'),
        content: Text('Details: ${state.requestDetails}'),
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