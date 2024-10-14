import 'package:universal_io/io.dart';

import 'package:path/path.dart' as p;

String extractFileExtension(File pickedFile) {
  final extension = p.extension(pickedFile.path);
  return extension;
}

String extractFileExtensionFromPath(String filepath){
  final extension = p.extension(filepath);
  return extension;
}

String extractFileName(String completePath) {
  final fileName = (completePath.split('/').last);
  return fileName;
}
