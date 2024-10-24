import 'package:core/base_classes/base_coordinator.dart';
import 'package:domain/usecase/credential_exchange/i_wallet_credentials_issuance_offer_request_use_case.dart';
import 'package:domain/usecase/manage_wallet_credentials/i_delete_wallet_credentials_use_case.dart';
import 'package:domain/usecase/wallet_credentials_list/i_wallet_credentials_list_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:presentation/wallet_credentials_list/navigation_handler/wallet_credentials_list_navigation_handler.dart';
import 'package:presentation/wallet_credentials_list/state/wallet_credentials_list_state.dart';

class WalletCredentialsListCoordinator
    extends BaseCoordinator<WalletCredentialsListState> {
  final IWalletCredentialsListUseCase getWalletCredentialsListUseCase;
  final IDeleteWalletCredentialsUseCase deleteWalletCredentialsUseCase;
  final WalletCredentialListNavigationHandler navigationHandler;
  final IWalletCredentialsOfferRequestUseCase
      walletCredentialsOfferRequestUseCase;

  WalletCredentialsListCoordinator(
      {required this.walletCredentialsOfferRequestUseCase,
      required this.getWalletCredentialsListUseCase,
      required this.deleteWalletCredentialsUseCase,
      required this.navigationHandler})
      : super(WalletCredentialsListState(credentialListState: []));

  Future<void> initialize(BuildContext context) async {
    var getList = await getWalletCredentialsListUseCase.getWalletCredKey();
    // Update the state with a copy of the credential list if it is not null
    if (getList != null) {
      state = state.copyWith(credentialListStateCopy: getList);
    }
  }

  Future<void> getWalletCredentialsList() async {
    var getList =
        await getWalletCredentialsListUseCase.fetchWalletCredentialsList();
    state = state.copyWith(credentialListStateCopy: getList);
  }

  Future<void> deleteWalletCredentialsById(
      String credentialId, bool isPermanent) async {
    await deleteWalletCredentialsUseCase.deleteWalletCredentialsById(
        credentialId, isPermanent);
  }

  Future<void> readyToShareCredentialId(String credentialId) async {

    var getResponse = await getWalletCredentialsListUseCase
            .getWalletResolvePresentationKey() ??
        '';
    var gerSharedResponse = await walletCredentialsOfferRequestUseCase
        .postWalletProcessCredentialRequest(credentialId, getResponse);

    if (gerSharedResponse != null && gerSharedResponse == true) {
      showSessionExpiredToast("Your Credential Id has been shared successfully");
      navigationHandler.navigateToSplash();
    } else {
      showSessionExpiredToast("Your Session has expired, Please proceed again");
    }
  }

  void navigateToSplash() {
    navigationHandler.navigateToSplash();
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
}
