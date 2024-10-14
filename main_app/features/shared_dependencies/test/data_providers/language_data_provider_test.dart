import 'package:core/ioc/di_container.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_dependencies/data_providers/language_data_provider.dart';
import 'package:task_manager/task_manager.dart';

void main() {
  late ILanguageDataProvider languageDataProvider;
  setUp(() {
    DIContainer.container.registerFactory((container) => TaskManager());
    languageDataProvider = LanguageDataProviderImpl(
        taskManager: DIContainer.container.resolve<TaskManager>());
  });
  group("Language Data Provider", () {
    test("""should write en and should read en from file""", () async {
      // arrange
      var testValue = {"": ""};
      await languageDataProvider.writeIntoLanguageFile(testValue);
      // act
      var value = await languageDataProvider.readFromLanguageFile();
      // assert
      expect(value, {});
    });
  });
}
