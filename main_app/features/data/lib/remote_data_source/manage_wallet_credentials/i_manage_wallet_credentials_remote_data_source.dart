
abstract class IManageWalletCredentialsRemoteDataSource {
  Future<bool?> deleteCredentialByIdAPI(String credentialId, bool isPermanent);
}
