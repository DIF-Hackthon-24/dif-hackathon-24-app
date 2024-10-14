import 'package:flutter/widgets.dart';

/// events added to [BaseBloc] sinkState must extend this class
abstract class BaseBlocPrimaryState {
  void call(dynamic param);
}

/// Called within the [SubClassOfBaseBloc] will pop the current page
class PopPageState extends BaseBlocPrimaryState {
  final dynamic returnedParam;

  PopPageState({this.returnedParam});

  @override
  void call(param) {
    if (param is BuildContext) {
      if (Navigator.canPop(param)) {
        Navigator.of(param).pop(returnedParam);
      }
    }
  }
}
