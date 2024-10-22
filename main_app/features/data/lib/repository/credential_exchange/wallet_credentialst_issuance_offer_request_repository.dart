import 'package:data/remote_data_source/credential_exchange/i_wallet_credentials_exchange_issuance_remote_data_source.dart';
import 'package:data/remote_data_source/wallet_credentials_list/model/wallet_credentials_list_model.dart';
import 'package:domain/entity/wallet_credentials_list/wallet_credentials_list_entity.dart';
import 'package:domain/repository/credential_exchange/i_wallet_credentials_issuance_offer_request_repository.dart';

class WalletCredentiaIssuanceOfferRequestRepository
    implements IWalletCredentialsIssuanceOfferRequestRepository {
  final IWalletCredentialsExchangeIssuanceRemoteDataSource
      walletCredentialsExchangeIssuanceRemoteDataSource;

  WalletCredentiaIssuanceOfferRequestRepository({
    required this.walletCredentialsExchangeIssuanceRemoteDataSource,
  });

  @override
  Future<List<WalletCredentialListEntity>?> postWalletCredentialOfferRequest(
      String offerRequest) async {
    final responseData = await walletCredentialsExchangeIssuanceRemoteDataSource
            .postWalletCredentialOfferRequestAPI(offerRequest)
        as WalletCredentialListModel;

    return responseData.walletCredentials
        ?.map((responseData) => WalletCredentialListEntity(
              id: responseData.id,
              wallet: responseData.wallet,
              document: responseData.document,
              disclosures: responseData.disclosures,
              addedOn: responseData.addedOn,
              format: responseData.format,
            ))
        .toList();
  }

  @override
  Future<List<WalletCredentialListEntity>?> postWalletMatchCredentialsRequest(
      String credentialRequest) async {
    final responseData = await walletCredentialsExchangeIssuanceRemoteDataSource
            .postWalletMatchCredentialsRequestAPI(credentialRequest)
        as WalletCredentialListModel;

    return responseData.walletCredentials
        ?.map((responseData) => WalletCredentialListEntity(
              id: responseData.id,
              wallet: responseData.wallet,
              document: responseData.document,
              disclosures: responseData.disclosures,
              addedOn: responseData.addedOn,
              format: responseData.format,
            ))
        .toList();
  }

  @override
  Future<List<WalletCredentialListEntity>?> postWalletProcessCredentialRequest(
      String credentialRequest) async {
    final responseData = await walletCredentialsExchangeIssuanceRemoteDataSource
            .postWalletProcessCredentialRequestAPI(credentialRequest)
        as WalletCredentialListModel;

    return responseData.walletCredentials
        ?.map((responseData) => WalletCredentialListEntity(
              id: responseData.id,
              wallet: responseData.wallet,
              document: responseData.document,
              disclosures: responseData.disclosures,
              addedOn: responseData.addedOn,
              format: responseData.format,
            ))
        .toList();
  }
}
