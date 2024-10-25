// permission_request_view.dart
import 'package:flutter/material.dart';
import 'package:presentation/permission_request/coordinator/permission_request_coordinator.dart';
import 'package:presentation/permission_request/state/permission_request_state.dart';
import 'package:widget_library/loading_widget.dart';

class PermissionRequestView extends StatelessWidget {
  const PermissionRequestView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Permission Request'),
      ),
      body: FutureBuilder<PermissionRequestState>(
        future: PermissionRequestCoordinator().fetchPermissionRequestData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingWidget();
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No data found'));
          } else {
            final state = snapshot.data!;
            return Column(
              children: [
                Text('Request Details: ${state.requestDetails}'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () => PermissionRequestCoordinator().grantPermission(context, state),
                      child: Text('Grant'),
                    ),
                    ElevatedButton(
                      onPressed: () => PermissionRequestCoordinator().denyPermission(context),
                      child: Text('Deny'),
                    ),
                  ],
                ),
              ],
            );
          }
        },
      ),
    );
  }
}