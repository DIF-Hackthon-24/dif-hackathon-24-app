

abstract class IDeleteWalletCredentialsByIdRepository {
    Future<bool?>  deleteWalletCredentialsById(String credentialId, bool isPermanent);

}
