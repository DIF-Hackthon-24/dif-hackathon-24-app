import 'package:core/navigation/i_route_manager.dart';
import 'package:flutter/material.dart';
import 'package:widget_library/change_application_popup.dart';
import 'package:widget_library/common_widget/theme/ps_theme.dart';

class APIErrorsRouteManager extends IRouteManager {
  static const apiErrorBottomSheet = 'api_error_bottom_sheet';
  static const coApplicantView = 'co_applicant_view';
  @override
  Widget getView(RouteSettings settings) {
    switch (settings.name) {
      default:
        throw Exception('Not implemented');
    }
  }

  @override
  Widget getBottomSheet(String bottomSheetName, arguments) {
    final theme =
        PSTheme().themeFor(arguments['themeName'] as String? ?? bottomSheetName);
    switch (bottomSheetName) {
      case APIErrorsRouteManager.apiErrorBottomSheet:
        return Theme(
          data: theme,
          child: ChangeApplicationBottomSheet(
            attributes: arguments['arguments'] as ShowModalBottomSheetInfoAttributes?,
          ),
        );
      default:
        throw Exception('Route ${arguments.number} not found');
    }
  }
}
