import 'package:domain/entity/wallet_credentials_list/wallet_credentials_list_entity.dart';

abstract class IWalletCredentialsIssuanceOfferRequestRepository {
  Future<List<WalletCredentialListEntity>?>  postWalletCredentialOfferRequest(String offerRequest);
}
