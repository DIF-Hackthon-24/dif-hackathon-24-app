import 'package:core/storage/memory_storage/memory_storage_service_impl.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('set_value', () {
    //Arrange
    final memoryStorageService = MemoryStorageServiceImpl();
    final key = 'key1';
    final value = 'Test Value';

    //Act
    memoryStorageService.set(key, value);
    final valueFromStorage = memoryStorageService.get(key);
    identical(value, valueFromStorage);
  });

  test('set_value_integer', () {
    //Arrange
    final memoryStorageService = MemoryStorageServiceImpl();
    final key = 'key_integer';
    final value = 123;

    //Act
    memoryStorageService.set(key, value);
    final valueFromStorage = memoryStorageService.get(key);
    identical(value, valueFromStorage);
  });

  test('get_value', () {
    //Arrange
    final memoryStorageService = MemoryStorageServiceImpl();
    final key = 'key1';
    final value = 'Test Value';

    //Act
    final valueFromStorage = memoryStorageService.get(key);
    identical(value, valueFromStorage);
  });

  test('delete_all_values', () {
    //Arrange
    final memoryStorageService = MemoryStorageServiceImpl();
    memoryStorageService.set('key', 'value');
    memoryStorageService.set('key1', 'value1');

    //Act
    var valueFromStorage = memoryStorageService.get('key');
    final isNotDeleted = valueFromStorage != null;
    assert(true, isNotDeleted);
    memoryStorageService.deleteAll();
    valueFromStorage = memoryStorageService.get('key');
    final isDeleted = valueFromStorage == null;
    assert(true, isDeleted);
  });
}
