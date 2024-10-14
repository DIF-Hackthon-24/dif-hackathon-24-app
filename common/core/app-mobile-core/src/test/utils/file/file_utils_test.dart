import 'dart:io';

import 'package:core/utils/file/file_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  test('file utils extractFileExtension ...', () async {
    var path = './textfile.txt';
    var file = File(path);
    expect(extractFileExtension(file), '.txt');
  });

  test('file utils extractFileExtensionFromPath ...', () async {
    var path = './textfile.txt';
    expect(extractFileExtensionFromPath(path), '.txt');
  });

  test('file utils extractFileName ...', () async {
    var path = './textfile.txt';
    expect(extractFileName(path), 'textfile.txt');
  });
}
