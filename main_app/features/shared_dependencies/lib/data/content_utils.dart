import 'package:core/logging/logger.dart';

class ContentUtils{

  String getStringFromArrayOfMap(int index,List content,String mapKey){
    try{
      return content[index][mapKey] ?? '';
    }catch(e){
      PSLogger.logError(e.toString());
      return '';
    }
  }

  String getStringFromArray(int index,List content){
    try{
      return content[index];
    }catch(e){
      PSLogger.logError(e.toString());
      return '';
    }
  }
}