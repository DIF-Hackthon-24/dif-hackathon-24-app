import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_dependencies/data/uuid_manager.dart';
import 'package:uuid/uuid.dart';

import 'uuid_manager_test.mocks.dart';

@GenerateMocks([Uuid])
void main() {
  late Uuid uuidClient;
  late UUIDManager uuidManager;

  setUp(
    () {
      uuidClient = MockUuid();
      uuidManager = UUIDManagerImpl(uuidClient: uuidClient);
    },
  );
  group('UUIDManager', () {
    test("should get string device id when uuid.getDeviceId is called", () async {
      // arrange
      const fakeUuid = "110ec58a-a0f2-4ac4-8393-c866d813b8d1";
      when(uuidClient.v4()).thenReturn(fakeUuid);
      // act
      var uuid = uuidManager.getUUIDForDevice();
      // assert
      expect(uuid, fakeUuid);
      verify(uuidClient.v4());
      verifyNoMoreInteractions(uuidClient);
    });
  });
}
