abstract class IConfigManager {
  Future<void> storeConfigData(String configData);

  Future<Map<String, dynamic>?> retrieveConfigData();

  Future<void> clearConfigData();

  Future<void> clearUserData();

  Future<void> clearNocData();
}
