import 'package:core/base_classes/base_coordinator.dart';
import 'package:domain/entity/wallet_credentials_list/wallet_credentials_list_entity.dart';
import 'package:domain/usecase/credential_exchange/i_wallet_credentials_issuance_offer_request_use_case.dart';
import 'package:flutter/widgets.dart';
import 'package:presentation/credential_exchange/navigation_handler/wallet_credentials_list_navigation_handler.dart';
import 'package:presentation/credential_exchange/state/wallet_credentials_offer_request_state.dart';

class _Constants {
  static const  offerRequestAcceptance = 'offer_request_acceptance';
  static const verifyCredentialId = 'verify_credential_id';
  static const processPresentation = 'process_presentation';
}

class WalletCredentialsOfferRequestCoordinator
    extends BaseCoordinator<WalletCredentialsOfferRequestState> {
  final IWalletCredentialsOfferRequestUseCase credentialsOfferRequestUseCase;
  final CredentialExchangeNavigationHandler navigationHandler;

  WalletCredentialsOfferRequestCoordinator({
    required this.credentialsOfferRequestUseCase,
    required this.navigationHandler,
  }) : super(WalletCredentialsOfferRequestState(
            getCredentialsOfferRequestData: ''));

  Future<void> initialize(BuildContext context) async {}

  Future<void> postWalletCredentialsOfferRequest(
      String issueCredentials) async {
    state =
        state.copyWith(getCredentialsOfferRequestDataCopy: issueCredentials);
  }

  Future<void> submitCredentialsOfferRequest(String? scanCode) async {
    var offerRequest = state.getCredentialsOfferRequestData;

    List<WalletCredentialListEntity>? postCredentialsOfferRequest = [];

    if (_Constants.offerRequestAcceptance == scanCode) {
      postCredentialsOfferRequest = await credentialsOfferRequestUseCase
          .postWalletCredentialOfferRequest(offerRequest);
    }
    else if (_Constants.processPresentation == scanCode) {
      postCredentialsOfferRequest = await credentialsOfferRequestUseCase
          .postWalletProcessCredentialRequest(offerRequest);
    }
    else if (_Constants.verifyCredentialId == scanCode) {
      postCredentialsOfferRequest = await credentialsOfferRequestUseCase
          .postWalletMatchCredentialsRequest(offerRequest);
    }

    if (postCredentialsOfferRequest!.isNotEmpty) {
      navigationHandler.navigateToWalletList();
    }
  }

  void navigateToSplash() {
    navigationHandler.navigateToSplash();
  }
}
