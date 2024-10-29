import 'package:data/remote_data_source/credential_exchange/i_wallet_credentials_exchange_issuance_remote_data_source.dart';
import 'package:data/remote_data_source/wallet_credentials_list/model/wallet_credentials_list_model.dart';
import 'package:domain/entity/wallet_credentials_list/wallet_credentials_list_entity.dart';
import 'package:domain/repository/credential_exchange/i_wallet_credentials_issuance_offer_request_repository.dart';

class WalletCredentialExchangeRequestRepository
    implements IWalletCredentialsIssuanceOfferRequestRepository {
  final IWalletCredentialsExchangeIssuanceRemoteDataSource
      walletCredentialsExchangeIssuanceRemoteDataSource;

  WalletCredentialExchangeRequestRepository({
    required this.walletCredentialsExchangeIssuanceRemoteDataSource,
  });

  @override
  Future<String?> postWalletCredentialResolvePresentationRequest(
      String offerRequest) async {
    final responseData = await walletCredentialsExchangeIssuanceRemoteDataSource
        .postWalletCredentialResolvePresentationRequestAPI(offerRequest);

    return responseData;
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
  Future<bool?> postWalletProcessCredentialRequest(
      String credentialRequest, String presentationResponse) async {
    final responseData = await walletCredentialsExchangeIssuanceRemoteDataSource
        .postWalletProcessCredentialRequestAPI(
            credentialRequest, presentationResponse);
    return responseData;
  }

  @override
  Future<List<WalletCredentialListEntity>?> postWalletCredentialOfferRequest(
      String offerRequest, bool isUserInputRequired) async {
    final responseData = await walletCredentialsExchangeIssuanceRemoteDataSource
        .postWalletCredentialOfferRequestAPI(
            offerRequest, isUserInputRequired) as WalletCredentialListModel;

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
  Future<String?> postWalletCredentialIssuanceRequest() async {
    final responseData = await walletCredentialsExchangeIssuanceRemoteDataSource
        .postWalletCredentialIssuanceRequestAPI();
    return responseData;
  }

  @override
  Future<bool?> postPermissionRequest(Map<String, dynamic>? permissionRequest) async{
    final responseData = await walletCredentialsExchangeIssuanceRemoteDataSource
        .postPermissionRequestAPI(permissionRequest);
    return responseData;
  }

}
