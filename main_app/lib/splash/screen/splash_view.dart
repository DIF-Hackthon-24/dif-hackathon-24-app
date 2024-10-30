import 'package:core/base_classes/base_view.dart';
import 'package:flutter/material.dart';
import 'package:main_app/splash/coordinator/splash_coordinator.dart';
import 'package:main_app/splash/state/splash_view_state.dart';
import 'package:widget_library/common_widget/app_bars/ps_appbar.dart';
import 'package:widget_library/common_widget/image/image_widget.dart';
import 'package:widget_library/ps_scaffold.dart';

final _formKey = GlobalKey<FormState>();


class SplashView extends StatelessWidget {
  final bool mockLogin;

  const SplashView({
    this.mockLogin = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BaseView<SplashCoordinator, SplashViewState>(
      setupCoordinator: (coordinator) {
        coordinator.initialize(mockLogin);
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
    SplashViewState state,
    SplashCoordinator coordinator,
  ) {
    return PSScaffold(
      appBarAttributes: PSAppBarAttributes(title: "My Digital Wallet",
      ),
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: PSImage(
                PSImageModel(
                  iconPath: 'assets/images/digital_wallet.png',
                  height: 220,
                ),
              ),
            ),
            const SizedBox(height: 30),
            _buildCTAButton(
              context,
              icon: Icons.verified_user,
              title: 'Identity Verification',
              onTap: () {
                // Handle Identity Verification action
                coordinator.navigateToCompleteIdentityVerification(true);
              },
            ),
            _buildCTAButton(
              context,
              icon: Icons.travel_explore,
              title: 'Traveler Profile',
              onTap: () {
                // Handle Credentials List action
                coordinator.navigateToPreferenceCollection();
              },
            ),
            _buildCTAButton(
              context,
              icon: Icons.list_alt,
              title: 'Credentials List',
              onTap: () {
                // Handle Credentials List action
                coordinator.navigateToWalletList();
              },
            ),
            _buildCTAButton(
              context,
              icon: Icons.qr_code_scanner,
              title: 'QR Code Scanner',
              onTap: () {
                // Handle QR Code Scanner action
                coordinator.navigateToWalletCredentialExchange();
              },
            ),
            _buildCTAButton(
              context,
              icon: Icons.nfc,
              title: 'NFC Reader',
              onTap: () {
                coordinator.onNFCReader();
              },
            ),
            _buildCTAButton(
              context,
              icon: Icons.chat,
              title: 'Chat',
              onTap: () {
                // Handle Credentials List action
                coordinator.navigateToChat();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCTAButton(BuildContext context,
      {required IconData icon, required String title, required VoidCallback onTap}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: const BorderSide(
          color: Colors.blue, // Set the border color here
          width: 2.0,         // Set the border width here
        ),
      ),
      child: ListTile(
        leading: Icon(icon, color: Theme.of(context).primaryColor),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.black)),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }
}
