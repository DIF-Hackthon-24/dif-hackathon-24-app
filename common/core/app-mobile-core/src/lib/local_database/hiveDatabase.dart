import 'package:core/local_database/i_localDatabase.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';

class HiveDatabase extends ILocalDatabase {
  late LazyBox _hiveBox;
  late TypeAdapter<dynamic>? _typeAdapter;
  bool isEncryptedBox = false;

  HiveDatabase(String boxName, bool? isEncryptedBox, TypeAdapter<dynamic>? adapter) {
    this.isEncryptedBox = isEncryptedBox ?? false;
    _typeAdapter = adapter;

    initializeHive(boxName).then((value) => _hiveBox = value);
  }

  Future<LazyBox> initializeHive(String boxName) async {
    LazyBox _box;
    List<int> _encryptionKey = Hive.generateSecureKey();

    final appDocumentDir = await getApplicationDocumentsDirectory();
    await Hive.initFlutter(appDocumentDir.path);

    if (_typeAdapter != null) {
      Hive.registerAdapter<dynamic>(_typeAdapter!);
    }

    if (isEncryptedBox == true) {
      _box = await Hive.openLazyBox(boxName, encryptionCipher: HiveAesCipher(_encryptionKey));
    } else {
      _box = await Hive.openLazyBox(boxName);
    }

    return _box;
  }

  @override
  Future<dynamic> get(String key) async {
    return await _hiveBox.get(key);
  }

  @override
  Future<dynamic> getAt<T>(int index) async {
    return await _hiveBox.getAt(index);
  }

  @override
  Future<int> add<T>(dynamic value) async {
    return await _hiveBox.add(value);
  }

  @override
  Future<void> put(String key, dynamic value) async {
    return await _hiveBox.put(key, value);
  }

  @override
  Future<void> putAt<T>(int index, dynamic value) async {
    return await _hiveBox.putAt(index, value);
  }
}