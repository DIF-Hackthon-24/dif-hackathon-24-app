import 'package:domain/entity/wallet_credentials_list/wallet_credentials_list_entity.dart';
import 'package:domain/repository/credential_exchange/i_wallet_credentials_issuance_offer_request_repository.dart';
import 'package:domain/usecase/credential_exchange/i_wallet_credentials_issuance_offer_request_use_case.dart';

class WalletCredentialsOfferRequestUseCase implements IWalletCredentialsOfferRequestUseCase {
  IWalletCredentialsIssuanceOfferRequestRepository walletCredentialsIssuanceOfferRequestRepository;

  WalletCredentialsOfferRequestUseCase({
    required this.walletCredentialsIssuanceOfferRequestRepository,
  });

  @override
  Future<List<WalletCredentialListEntity>?> postWalletCredentialOfferRequest(String offerRequest) async {
    return await walletCredentialsIssuanceOfferRequestRepository.postWalletCredentialOfferRequest(offerRequest);
  }

}
