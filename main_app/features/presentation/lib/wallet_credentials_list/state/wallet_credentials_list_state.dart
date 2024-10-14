
import 'package:domain/entity/wallet_credentials_list/wallet_credentials_list_entity.dart';

class WalletCredentialsListState {
  List<WalletCredentialListEntity> credentialListState;

  WalletCredentialsListState({
    this.credentialListState = const [],
  });

  WalletCredentialsListState copyWith({
    List<WalletCredentialListEntity>? credentialListStateCopy,
  }) {
    return WalletCredentialsListState(
      credentialListState: credentialListStateCopy ?? credentialListState,
    );
  }
}