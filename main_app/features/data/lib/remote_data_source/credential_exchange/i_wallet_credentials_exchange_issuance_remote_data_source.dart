import 'package:data/remote_data_source/wallet_credentials_list/model/wallet_credentials_list_model.dart';

abstract class IWalletCredentialsExchangeIssuanceRemoteDataSource {
  Future<WalletCredentialListModel?> postWalletCredentialOfferRequestAPI(String credentialOfferRequest, bool requireUserInput);
  Future<String?> postWalletCredentialResolvePresentationRequestAPI(String credentialOfferRequest);
  Future<WalletCredentialListModel?> postWalletMatchCredentialsRequestAPI(String credentialRequest);
  Future<bool?> postWalletProcessCredentialRequestAPI(String credentialRequest,String presentationResponse);

}
