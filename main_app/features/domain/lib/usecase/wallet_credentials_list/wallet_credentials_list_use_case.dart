import 'package:domain/entity/wallet_credentials_list/wallet_credentials_list_entity.dart';
import 'package:domain/repository/wallet_credentials_list/i_wallet_credentials_list_repository.dart';
import 'package:domain/usecase/wallet_credentials_list/i_wallet_credentials_list_use_case.dart';

class WalletCredentialsListUseCase implements IWalletCredentialsListUseCase {
  IWalletCredentialsListRepository walletCredentialsListRepository;

  WalletCredentialsListUseCase({
    required this.walletCredentialsListRepository,
  });

  @override
  void onDispose() {
    walletCredentialsListRepository.onDispose();
  }

  @override
  Future<void> init() async {}

  @override
  Future<List<WalletCredentialListEntity>?> fetchWalletCredentialsList() async {

    return await walletCredentialsListRepository.fetchWalletCredentialsList();
  }

  @override
  Future<List<WalletCredentialListEntity>?> getWalletCredKey() async {

    return await walletCredentialsListRepository.getWalletCredKey();
  }

  @override
  Future<String?> getWalletResolvePresentationKey() async{
    return await walletCredentialsListRepository.getWalletResolvePresentationKey();
  }
}
