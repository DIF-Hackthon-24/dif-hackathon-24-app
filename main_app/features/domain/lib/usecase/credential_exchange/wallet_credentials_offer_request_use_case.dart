import 'package:domain/entity/wallet_credentials_list/wallet_credentials_list_entity.dart';
import 'package:domain/repository/credential_exchange/i_wallet_credentials_issuance_offer_request_repository.dart';
import 'package:domain/usecase/credential_exchange/i_wallet_credentials_issuance_offer_request_use_case.dart';

class WalletCredentialsOfferRequestUseCase
    implements IWalletCredentialsOfferRequestUseCase {
  IWalletCredentialsIssuanceOfferRequestRepository
      walletCredentialsIssuanceOfferRequestRepository;

  WalletCredentialsOfferRequestUseCase({
    required this.walletCredentialsIssuanceOfferRequestRepository,
  });

  @override
  Future<String?> postWalletCredentialResolvePresentationRequest(
      String offerRequest) async {
    return await walletCredentialsIssuanceOfferRequestRepository
        .postWalletCredentialResolvePresentationRequest(offerRequest);
  }

  @override
  Future<List<WalletCredentialListEntity>?> postWalletMatchCredentialsRequest(
      String credentialRequest) async {
    return await walletCredentialsIssuanceOfferRequestRepository
        .postWalletMatchCredentialsRequest(credentialRequest);
  }

  @override
  Future<bool?> postWalletProcessCredentialRequest(
      String credentialRequest, String presentationResponse) async {
    return await walletCredentialsIssuanceOfferRequestRepository
        .postWalletProcessCredentialRequest(
            credentialRequest, presentationResponse);
  }

  @override
  Future<List<WalletCredentialListEntity>?> postWalletCredentialOfferRequest(
      String offerRequest, bool isUserInputRequired) async {
    return await walletCredentialsIssuanceOfferRequestRepository
        .postWalletCredentialOfferRequest(offerRequest, isUserInputRequired);
  }

  @override
  Future<String?> postWalletCredentialIssuanceRequest() async{
    return await walletCredentialsIssuanceOfferRequestRepository
        .postWalletCredentialIssuanceRequest();
  }

  @override
  Future<bool?> postPermissionRequest(Map<String, dynamic>? permissionRequest) async {
    return await walletCredentialsIssuanceOfferRequestRepository
        .postPermissionRequest(permissionRequest);
  }
}
