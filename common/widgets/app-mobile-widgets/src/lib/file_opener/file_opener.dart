import 'package:core/logging/logger.dart';
import 'package:open_filex/open_filex.dart';

abstract class IFileOpener{
  Future<void> openFile(String filePath);
}

class FileOpener extends IFileOpener{
  @override
  Future<void> openFile(String filePath) async {
    try{
    await OpenFilex.open(filePath);
    }
    catch(error){
      PSLogger.logError(error.toString());
    }
  }

}