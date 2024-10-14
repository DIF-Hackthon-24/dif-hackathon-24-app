abstract class IDeleteWalletCredentialsUseCase {
 Future<bool?> deleteWalletCredentialsById(String credentialId, bool isPermanent);
}
