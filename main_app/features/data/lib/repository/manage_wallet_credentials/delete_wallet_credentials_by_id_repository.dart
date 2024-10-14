import 'package:data/remote_data_source/manage_wallet_credentials/i_manage_wallet_credentials_remote_data_source.dart';
import 'package:domain/repository/manage_wallet_credentials/i_delete_wallet_credentials_by_id_repository.dart';

class DeleteWalletCredentialsByIdRepository
    implements IDeleteWalletCredentialsByIdRepository {
  final IManageWalletCredentialsRemoteDataSource
      manageWalletCredentialsRemoteDataSource;

  DeleteWalletCredentialsByIdRepository({
    required this.manageWalletCredentialsRemoteDataSource,
  });

  @override
  Future<bool?> deleteWalletCredentialsById(String credentialId, bool isPermanent) async {
    final responseData = await manageWalletCredentialsRemoteDataSource
        .deleteCredentialByIdAPI(credentialId,isPermanent) ;

    return responseData;
  }
}
