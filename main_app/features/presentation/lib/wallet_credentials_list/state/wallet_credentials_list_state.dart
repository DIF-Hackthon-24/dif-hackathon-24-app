
import 'package:domain/entity/wallet_credentials_list/wallet_credentials_list_entity.dart';

class WalletCredentialsListState {
  List<WalletCredentialListEntity> credentialListState;
  Map<String, dynamic>? permissionRequest;

  WalletCredentialsListState({
    this.credentialListState = const [],
    this.permissionRequest ,
  });

  WalletCredentialsListState copyWith({
    List<WalletCredentialListEntity>? credentialListStateCopy,
    Map<String, dynamic>? permissionRequestCopy,
  }) {
    return WalletCredentialsListState(
      credentialListState: credentialListStateCopy ?? credentialListState,
      permissionRequest: permissionRequestCopy ?? permissionRequest,
    );
  }
}