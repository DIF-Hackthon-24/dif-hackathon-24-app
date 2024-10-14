import 'package:data/remote_data_source/wallet_credentials_list/model/wallet_credentials_list_model.dart';

abstract class IGetWalletCredentialListRemoteDataSource {
  Future<WalletCredentialListModel?> getWalletCredentialListAPI();
  Future<WalletCredentialListModel?> getWalletCredKey();
}
