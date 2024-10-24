import 'package:domain/entity/wallet_credentials_list/wallet_credentials_list_entity.dart';

abstract class IWalletCredentialsListRepository {
  Future<void> init();

  void onDispose();

  Future<List<WalletCredentialListEntity>?>  fetchWalletCredentialsList();
  Future<List<WalletCredentialListEntity>?> getWalletCredKey();
  Future<String?> getWalletResolvePresentationKey();
}
