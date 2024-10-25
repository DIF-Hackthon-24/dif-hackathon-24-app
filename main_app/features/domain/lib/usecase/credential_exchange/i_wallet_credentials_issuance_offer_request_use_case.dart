import 'package:domain/entity/wallet_credentials_list/wallet_credentials_list_entity.dart';

abstract class IWalletCredentialsOfferRequestUseCase {
  Future<List<WalletCredentialListEntity>?>  postWalletCredentialOfferRequest(String offerRequest,bool isUserInputRequired);
  Future<String?>  postWalletCredentialResolvePresentationRequest(String offerRequest);
  Future<List<WalletCredentialListEntity>?> postWalletMatchCredentialsRequest(String credentialRequest);
  Future<bool?> postWalletProcessCredentialRequest(String credentialRequest, String presentationResponse);
}
