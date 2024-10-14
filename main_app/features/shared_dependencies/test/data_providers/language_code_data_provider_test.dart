import 'package:core/ioc/di_container.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_dependencies/data_providers/language_code_data_provider.dart';
import 'package:task_manager/task_manager.dart';

void main() {
  late ILanguageCodeDataProvider languageCodeDataProvider;
  setUp(() {
    DIContainer.container.registerFactory((container) => TaskManager());
    languageCodeDataProvider = LanguageCodeDataProviderImpl(
        taskManager: DIContainer.container.resolve<TaskManager>());
  });
  group("Language Code Data Provider", () {
    test("""should write en and should read en from file""", () async {
      // arrange
      var testValue = "";
      await languageCodeDataProvider.storeLanguageKey(testValue);
      // act
      var value = await languageCodeDataProvider.getLanguageKey();
      // assert
      expect(value, testValue);
    });
  });
}
