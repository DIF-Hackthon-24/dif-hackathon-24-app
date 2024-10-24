import 'package:core/base_classes/base_coordinator.dart';
import 'package:domain/entity/wallet_credentials_list/wallet_credentials_list_entity.dart';
import 'package:domain/usecase/credential_exchange/i_wallet_credentials_issuance_offer_request_use_case.dart';
import 'package:flutter/widgets.dart';
import 'package:presentation/credential_exchange/navigation_handler/wallet_credentials_list_navigation_handler.dart';
import 'package:presentation/credential_exchange/state/wallet_credentials_offer_request_state.dart';

class _Constants {
  static const offerRequestAcceptance = 'offer_request_acceptance';
  static const verifyCredentialId = 'verify_credential_id';
  static const processPresentation = 'process_presentation';
}

class WalletCredentialsOfferRequestCoordinator
    extends BaseCoordinator<WalletCredentialsOfferRequestState> {
  final IWalletCredentialsOfferRequestUseCase credentialsExchangeRequestUseCase;
  final CredentialExchangeNavigationHandler navigationHandler;

  WalletCredentialsOfferRequestCoordinator({
    required this.credentialsExchangeRequestUseCase,
    required this.navigationHandler,
  }) : super(WalletCredentialsOfferRequestState(
            getCredentialsOfferRequestData: ''));

  Future<void> initialize(BuildContext context) async {}

  Future<void> postWalletCredentialsOfferRequest(
      String issueCredentials) async {
    state =
        state.copyWith(getCredentialsOfferRequestDataCopy: issueCredentials);
  }

  Future<void> submitCredentialsExchangeRequest() async {
    var offerRequest = state.getCredentialsOfferRequestData;

    List<WalletCredentialListEntity>? postCredentialsExchangeRequest = [];

    var resolvePresentationRequest = await credentialsExchangeRequestUseCase
        .postWalletCredentialResolvePresentationRequest(offerRequest);
    postCredentialsExchangeRequest = await credentialsExchangeRequestUseCase
        .postWalletMatchCredentialsRequest(
            getPresentationDefinitionDecodedURL(resolvePresentationRequest!));

    if (postCredentialsExchangeRequest!.isNotEmpty) {
      navigationHandler.navigateToWalletList();
    }
  }

  void navigateToSplash() {
    navigationHandler.navigateToSplash();
  }

  String getPresentationDefinitionDecodedURL(String encodedURL) {
    // Parse the URL
    Uri uri = Uri.parse(encodedURL);

    // Extract and decode the 'presentation_definition' parameter
    String encodedPresentationDefinition =
        uri.queryParameters['presentation_definition'] ?? '';
    String decodedPresentationDefinition =
        Uri.decodeComponent(encodedPresentationDefinition);

    return decodedPresentationDefinition;
  }
}
