import 'package:uuid/uuid.dart';

abstract class UUIDManager {
  String getUUIDForDevice();
}

class UUIDManagerImpl implements UUIDManager {
  late final Uuid uuidClient;
  UUIDManagerImpl({
    required this.uuidClient,
  });

  @override
  String getUUIDForDevice() {
    return uuidClient.v4();
  }
}
