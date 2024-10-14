import 'package:flutter/material.dart';

///All the modules/features which contain screens to be displayed should implement
///this interface in their module/feature

abstract class IRouteManager {
  ///getRoute returns a MaterialPageRoute to be displayed on screen.
  /// Routesettings contains the screen/view name and arguments for view contructor
  Widget getView(RouteSettings settings);

  ///getDialog returns a Widget to be displayed on screen.
  Widget getDialog(String dialogName, dynamic arguments) {
    throw Exception('Dialog $dialogName not found');
  }

  ///getBottomSheet returns a widget to be displayed on screen.
  Widget getBottomSheet(String bottomSheetName, dynamic arguments) {
    throw Exception('Bottomsheet $bottomSheetName not found');
  }
}
