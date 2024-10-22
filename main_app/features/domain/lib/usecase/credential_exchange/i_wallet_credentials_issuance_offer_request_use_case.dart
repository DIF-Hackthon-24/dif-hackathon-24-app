import 'package:domain/entity/wallet_credentials_list/wallet_credentials_list_entity.dart';

abstract class IWalletCredentialsOfferRequestUseCase {
  Future<List<WalletCredentialListEntity>?>  postWalletCredentialOfferRequest(String offerRequest);
  Future<List<WalletCredentialListEntity>?> postWalletMatchCredentialsRequest(String credentialRequest);
  Future<List<WalletCredentialListEntity>?> postWalletProcessCredentialRequest(String credentialRequest);
}
