import 'package:core/base_classes/base_view.dart';
import 'package:core/navigation/navigation_manager.dart';
import 'package:flutter/material.dart';
import 'package:presentation/wallet_credentials_list/coordinator/wallet_credentials_list_coordinator.dart';
import 'package:presentation/wallet_credentials_list/state/wallet_credentials_list_state.dart';
import 'package:presentation/wallet_credentials_list/widgets/dwn_permission_request_widget.dart';
import 'package:presentation/wallet_credentials_list/widgets/wallet_credentials_list_widget.dart';
import 'package:widget_library/common_widget/app_bars/ps_appbar.dart';
import 'package:widget_library/ps_scaffold.dart';

class WalletCredentialsListView extends StatelessWidget {
  final String? recipient;
  final Map<String, dynamic>? permissionRequest;


  const WalletCredentialsListView({super.key, required this.recipient, this.permissionRequest});

  @override
  Widget build(BuildContext context) {
    return BaseView<WalletCredentialsListCoordinator,
        WalletCredentialsListState>(
      setupCoordinator: (coordinator) async {
        await coordinator.initialize(context,permissionRequest);
      },
      builder: (
        context,
        state,
        viewModel,
      ) =>
          buildWithState(
        context,
        state,
        viewModel,
      ),
    );
  }

  Widget buildWithState(
    BuildContext context,
    WalletCredentialsListState state,
    WalletCredentialsListCoordinator coordinator,
  ) {
    return PSScaffold(
      appBarAttributes: PSAppBarAttributes(
        title: recipient!.isEmpty
            ? "Wallet Credentials List"
            : "Permission Request",
        left: [
          PSAppBarButtonAttributes(
            type: PSAppBarButtons.back,
            onPressed: () => coordinator.navigateToSplash(),
          ),
        ],
      ),
      body: recipient!.isEmpty
          ? WalletCredListWidget(
              credentialListItems: state.credentialListState,
              onRefresh: coordinator.getWalletCredentialsList,
              onDelete: coordinator.deleteWalletCredentialsById,
              onShared: coordinator.readyToShareCredentialId,
            )
          : Padding(
              padding: const EdgeInsets.all(20.0),
              child: PermissionRequestWidget(
                recipient: recipient ?? '',
                onGranted: coordinator.grantRequestPermission,
              ),
            ),
    );
  }
}
