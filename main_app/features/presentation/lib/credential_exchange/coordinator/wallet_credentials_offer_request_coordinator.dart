import 'dart:convert';

import 'package:core/base_classes/base_coordinator.dart';
import 'package:domain/entity/wallet_credentials_list/wallet_credentials_list_entity.dart';
import 'package:domain/usecase/credential_exchange/i_wallet_credentials_issuance_offer_request_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:presentation/credential_exchange/navigation_handler/wallet_credentials_list_navigation_handler.dart';
import 'package:presentation/credential_exchange/state/wallet_credentials_offer_request_state.dart';

class _Constants {
  static const issuanceRequests = 'issuancerequests';
  static const presentationRequests = 'presentationrequests';
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

    if (offerRequest.toLowerCase().contains(_Constants.issuanceRequests)) {
      var postCredentialsExchangeRequest =
          await credentialsExchangeRequestUseCase
              .postWalletCredentialOfferRequest(offerRequest, false);

      if (postCredentialsExchangeRequest!.isNotEmpty) {
        showSessionExpiredToast(
            "The requested Credentials has been issued successfully");
        navigationHandler.navigateToSplash();
      }
    }

    if (offerRequest.toLowerCase().contains(_Constants.presentationRequests)) {
      var resolvePresentationRequest = await credentialsExchangeRequestUseCase
          .postWalletCredentialResolvePresentationRequest(offerRequest);
      postCredentialsExchangeRequest = await credentialsExchangeRequestUseCase
          .postWalletMatchCredentialsRequest(
              getPresentationDefinitionDecodedURL(resolvePresentationRequest!));

      if (postCredentialsExchangeRequest!.isNotEmpty) {
        navigationHandler.navigateToWalletList('');
      }
    }

    if (offerRequest.isNotEmpty) {
      Map<String, dynamic>? permissionRequestData = jsonDecode(offerRequest);
      navigationHandler.navigateToWalletList(
          _processDid(permissionRequestData!['recipient'] ?? ''),
          permissionRequest: permissionRequestData);
    }
  }

  Future<void> uploadDocumentRequest() async {
    var getIdentityData = await credentialsExchangeRequestUseCase
        .postWalletCredentialIssuanceRequest();
    if (getIdentityData!.isNotEmpty) {
      var postCredentialsExchangeRequest =
          await credentialsExchangeRequestUseCase
              .postWalletCredentialOfferRequest(getIdentityData, false);
      if (postCredentialsExchangeRequest!.isNotEmpty) {
        showSessionExpiredToast("Document verified successfully!");
        navigationHandler.navigateToSplash();
      }
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

  void showSessionExpiredToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  String _processDid(String did) {
    List<String> components = did.split(':');
    if (components.length > 1) {
      return components.sublist(2).join(':');
    } else {
      return 'Invalid DID format';
    }
  }
}
