import 'package:core/base_classes/base_view.dart';
import 'package:flutter/material.dart';
import 'package:presentation/permission_request/coordinator/permission_request_coordinator.dart';
import 'package:presentation/permission_request/state/permission_request_state.dart';
import 'package:presentation/permission_request/navigation_handler/permission_request_navigation_handler.dart';
import 'package:widget_library/loading_widget.dart';
import 'package:presentation/credential_exchange/widgets/wallet_credentials_offer_request_widget.dart';

import 'package:widget_library/common_widget/app_bars/ps_appbar.dart';
import 'package:widget_library/ps_scaffold.dart';

class PermissionRequestView extends StatelessWidget {
  const PermissionRequestView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<PermissionRequestCoordinator,
        PermissionRequestState>(
      setupCoordinator: (coordinator) async {
        await coordinator.initialize(context);
      },
      builder: (context,
          state,
          viewModel,) =>
          buildWithState(
            context,
            state,
            viewModel,
          ),
    );
  }

  Widget buildWithState(
      BuildContext context,
      PermissionRequestState state,
      PermissionRequestCoordinator coordinator,
      ) {
    return PSScaffold(
      appBarAttributes: PSAppBarAttributes(title: "Permission Request", left: [
        PSAppBarButtonAttributes(
          type: PSAppBarButtons.back,
          onPressed: () => coordinator.navigateToSplash(),
        ),
      ],),
      body:
      Column(
        children: [
          Text('Request Details: ${state.getPermissionRequestData}'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => coordinator.grantPermission(context, state),
                child: Text('Grant'),
              ),
              ElevatedButton(
                onPressed: () => coordinator.denyPermission(context),
                child: Text('Deny'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}