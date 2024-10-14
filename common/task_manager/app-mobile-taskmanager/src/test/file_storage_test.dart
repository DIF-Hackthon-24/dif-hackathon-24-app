import 'dart:io';

import 'package:core/storage/file_storage/file_storage_service_impl.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const channel = MethodChannel('plugins.flutter.io/path_provider');
  channel.setMockMethodCallHandler((MethodCall methodCall) async {
    return '.';
  });

  test('create_file', () async {
    //Arrange
    final fileStorageService = FileStorageServiceImpl();
    final key = 'test_file';
    final content = 'Test content';
    final directory = await getApplicationDocumentsDirectory();
    var filePath = directory.path + key + '.txt';

    //Act
    final _ = await fileStorageService.createFile(key, content: content);
    final checkPathExistence = await Directory(filePath).exists();
    assert(true, checkPathExistence);
  });

  test('get_file', () async {
    //Arrange
    final fileStorageService = FileStorageServiceImpl();
    final key = 'test_file';
    final content = 'Test content';

    //Act
    var file = await fileStorageService.getFile(key);
    var fileContent = await file.readAsString();

    final isEqual = fileContent == content;
    assert(true, isEqual);
  });

  test('append_to_file', () async {
    //Arrange
    final fileStorageService = FileStorageServiceImpl();
    final key = 'test_file';
    final content = 'Test content';
    final appendedContent = 'Appended content';

    //Act
    await fileStorageService.appendToFile(key, content: appendedContent);
    var file = await fileStorageService.getFile(key);
    var fileContent = await file.readAsString();

    final isEqual = fileContent == (content + appendedContent);
    assert(true, isEqual);
  });

  test('delete_file', () async {
    //Arrange
    final fileStorageService = FileStorageServiceImpl();
    final key = 'test_file';
    final directory = await getApplicationDocumentsDirectory();
    var filePath = directory.path + key + '.txt';

    //Act
    await fileStorageService.deleteFile(key);

    final checkPathExistence = !await Directory(filePath).exists();
    assert(true, checkPathExistence);
  });

  test('delete_all_files', () async {
    //Arrange
    final fileStorageService = FileStorageServiceImpl();
    final directory = await getApplicationDocumentsDirectory();

    //Act
    await fileStorageService.createFile('fileName1', content: 'content1');
    await fileStorageService.createFile('fileName2', content: 'content2');
    await fileStorageService.createFile('fileName3', content: 'content3');
    await fileStorageService.deleteAll();

    final inexistent = !(await Directory('$directory/local_files').exists());
    assert(true, inexistent);
  });
}
