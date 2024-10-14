
import 'package:core/logging/logger.dart';
import 'package:core/utils/extensions/string_extensions.dart';

enum ErrorType{
  Camunda,
  API,
}

class _Constants{
  static const String codeKey = 'code';
  static const String messageKey = 'message';
  static const String ineligibilityReasonsKey = 'ineligibilityReason';
  static const String camundaErrorKey = 'CAMUNDA_ERRORS';
  static const String errorCodeKey = 'errorCode';
}

abstract class IErrorManager{
  void initializeErrorMessage(Map<String,dynamic> content);
  String getErrorMessage(ErrorType errorType,String errorCode);
}

class ErrorManager extends IErrorManager{
  static List<dynamic> camundaErrors = [];
  static List<dynamic> apiErrors = [];



  @override
  void initializeErrorMessage(Map<String, dynamic> content) {
    camundaErrors = (content[_Constants.ineligibilityReasonsKey] ?? {})[_Constants.camundaErrorKey] ?? [];
    apiErrors = _getAPIerrors(content);
  }


  List<dynamic> _getAPIerrors(Map<String, dynamic> content){
    var errors = [];
    var attrs = (content[_Constants.errorCodeKey] as Map<String,dynamic>);
    attrs.forEach((key, value) { 
      if(value is List){
        errors.addAll(value);
      }
    });

    return errors;
  }

  @override
  String getErrorMessage(ErrorType errorType,String errorCode){
    if(errorCode.isEmpty){
      return "";
    }
    switch(errorType){
      case ErrorType.Camunda:
        return _getCamundaError(errorCode);

      case ErrorType.API:
        return _getAPIError(errorCode);

      default:
        return errorCode;
    }
  }
  

  String _getCamundaError(String errorCode){
    try{
    int index = camundaErrors.indexWhere((element) => element[_Constants.codeKey] == errorCode);
    if(index != -1){
      return (camundaErrors[index] ?? {})[_Constants.messageKey] ?? "";
    }
    return errorCode;
    }catch(e){
      PSLogger.logError(e.toString());
      return errorCode;
    }
  }
  
  String _getAPIError(String errorCode) {
    try{
    int index = apiErrors.indexWhere((element) => (element[_Constants.codeKey] as String? ?? "").equalsIgnoreCase(errorCode));
    int defaultErrorIdx = apiErrors.indexWhere((element) => element[_Constants.codeKey] == 'XX-XX-XX-XXX');
    if(index != -1){
      return (apiErrors[index] ?? {})[_Constants.messageKey] ?? "";
    }
    else if(errorCode.split('-').length == 4){
      var apiCode = "${errorCode.split('-')[1]}-${errorCode.split('-')[2]}";
      var idx = apiErrors.indexWhere((element) => element[_Constants.codeKey] == apiCode);
      if(idx != -1){
        return apiErrors[idx][_Constants.messageKey];
      }
    }
      return (apiErrors[defaultErrorIdx] ?? {})[_Constants.messageKey] ?? "";
    }catch(e){
      PSLogger.logError(e.toString());
      return errorCode;
    }
  }
}