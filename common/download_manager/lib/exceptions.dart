import 'package:flutter_downloader/flutter_downloader.dart';

class PermissionNotGrantedException extends FlutterDownloaderException{
  PermissionNotGrantedException({required super.message});
}