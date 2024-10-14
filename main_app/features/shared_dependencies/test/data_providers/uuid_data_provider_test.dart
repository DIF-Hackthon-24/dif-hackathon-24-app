import 'package:core/ioc/di_container.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_dependencies/data/uuid_manager.dart';
import 'package:shared_dependencies/data_providers/uuid_data_provider.dart';
import 'package:task_manager/task_manager.dart';
import 'package:uuid/uuid.dart';

import '../data/uuid_manager_test.mocks.dart';

void main() {
  late UUIDDataProvider uuidDataProvider;
  late Uuid uuidClient;
  setUp(() {
    uuidClient = MockUuid();
    DIContainer.container.registerFactory((container) => TaskManager());
    uuidDataProvider = UUIDDataProviderImpl(
      taskManager: DIContainer.container.resolve<TaskManager>(),
      uuidManager: UUIDManagerImpl(
        uuidClient: uuidClient,
      ),
    );
  });
  group("Language Data Provider", () {
    test("""should write en and should read en from file""", () async {
      // arrange
      const fakeUuid = "110ec58a-a0f2-4ac4-8393-c866d813b8d1";
      when(uuidClient.v4()).thenReturn(fakeUuid);
      // act
      var result = await uuidDataProvider.getUuidFromSecureStorage();
      // assert
      expect(result, "");
    });
  });
}
