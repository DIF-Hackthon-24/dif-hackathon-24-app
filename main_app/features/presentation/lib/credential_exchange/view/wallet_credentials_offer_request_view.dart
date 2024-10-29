import 'package:core/base_classes/base_view.dart';
import 'package:flutter/material.dart';
import 'package:presentation/credential_exchange/coordinator/wallet_credentials_offer_request_coordinator.dart';
import 'package:presentation/credential_exchange/state/wallet_credentials_offer_request_state.dart';
import 'package:presentation/credential_exchange/widgets/wallet_credentials_offer_request_widget.dart';
import 'package:presentation/credential_exchange/widgets/wallet_identity_verification_document_widget.dart';
import 'package:widget_library/common_widget/app_bars/ps_appbar.dart';
import 'package:widget_library/ps_scaffold.dart';

class WalletCredentialsOfferRequestView extends StatelessWidget {
  final bool mode;

  const WalletCredentialsOfferRequestView({super.key, required this.mode});

  @override
  Widget build(BuildContext context) {
    return BaseView<WalletCredentialsOfferRequestCoordinator,
        WalletCredentialsOfferRequestState>(
      setupCoordinator: (coordinator) async {
        await coordinator.initialize(context);
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
    WalletCredentialsOfferRequestState state,
    WalletCredentialsOfferRequestCoordinator coordinator,
  ) {
    return PSScaffold(
      appBarAttributes: PSAppBarAttributes(
        title:
            mode ? "Complete Identity Verification" : "Wallet QR Code Scanner",
        left: [
          PSAppBarButtonAttributes(
            type: PSAppBarButtons.back,
            onPressed: () => coordinator.navigateToSplash(),
          ),
        ],
      ),
      body: mode
          ? DocumentUploadWidget(
              submitButtonPressed: coordinator.uploadDocumentRequest)
          : CredentialOfferInputFormWidget(
              attributes: CredentialOfferInputFormAttributes(
                  offerRequestData: state.getCredentialsOfferRequestData,
                  issueOfferRequestInputForm:
                      coordinator.postWalletCredentialsOfferRequest,
                  submitButtonPressed:
                      coordinator.submitCredentialsExchangeRequest),
            ),
    );
  }
}
