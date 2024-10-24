import 'package:data/remote_data_source/wallet_credentials_list/i_wallet_credentials_list_remote_data_source.dart';
import 'package:data/remote_data_source/wallet_credentials_list/model/wallet_credentials_list_model.dart';
import 'package:domain/entity/wallet_credentials_list/wallet_credentials_list_entity.dart';
import 'package:domain/repository/wallet_credentials_list/i_wallet_credentials_list_repository.dart';

class WalletCredentialsListRepository
    implements IWalletCredentialsListRepository {
  final IGetWalletCredentialListRemoteDataSource
      getWalletCredentialListRemoteDataSource;

  WalletCredentialsListRepository({
    required this.getWalletCredentialListRemoteDataSource,
  });

  @override
  Future<void> init() async {}

  @override
  void onDispose() {}

  @override
  Future<List<WalletCredentialListEntity>?> fetchWalletCredentialsList() async {
    final responseData = await getWalletCredentialListRemoteDataSource
        .getWalletCredentialListAPI() as WalletCredentialListModel;

    return responseData.walletCredentials?.map((responseData)=>WalletCredentialListEntity(
      id: responseData.id,
      wallet: responseData.wallet,
      document: responseData.document,
      disclosures: responseData.disclosures,
      addedOn: responseData.addedOn,
      format: responseData.format,
      deletedOn: responseData.deletedOn,
    )).toList();
  }

  @override
  Future<List<WalletCredentialListEntity>?> getWalletCredKey() async{
    final responseData = await getWalletCredentialListRemoteDataSource
        .getWalletCredKey() as WalletCredentialListModel;

    return responseData.walletCredentials?.map((responseData)=>WalletCredentialListEntity(
      id: responseData.id,
      wallet: responseData.wallet,
      document: responseData.document,
      disclosures: responseData.disclosures,
      addedOn: responseData.addedOn,
      format: responseData.format,
      deletedOn: responseData.deletedOn,
    )).toList();
  }

  @override
  Future<String?> getWalletResolvePresentationKey() async{

    final responseData = await getWalletCredentialListRemoteDataSource
        .getWalletResolvePresentationKey() ;

    return responseData;
  }


}
