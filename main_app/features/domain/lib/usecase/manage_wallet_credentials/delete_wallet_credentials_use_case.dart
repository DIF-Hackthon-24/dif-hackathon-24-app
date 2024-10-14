import 'package:domain/repository/manage_wallet_credentials/i_delete_wallet_credentials_by_id_repository.dart';
import 'package:domain/usecase/manage_wallet_credentials/i_delete_wallet_credentials_use_case.dart';

class DeleteWalletCredentialsUseCase implements IDeleteWalletCredentialsUseCase {
  IDeleteWalletCredentialsByIdRepository deleteWalletCredentialsByIdRepository;

  DeleteWalletCredentialsUseCase({
    required this.deleteWalletCredentialsByIdRepository,
  });


  @override
  Future<bool?> deleteWalletCredentialsById(String credentialId, bool isPermanent) async {

    return await deleteWalletCredentialsByIdRepository.deleteWalletCredentialsById(credentialId,isPermanent);
  }

}
