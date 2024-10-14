import 'package:widget_library/common_widget/page_header/text_ui_data_model.dart';
import 'package:widget_library/common_widget/static_text/PSText.dart';

class StepperWidgetAttributes {
  final List<TextUIDataModel> instructions;
  final PSTextStyleVariant numberStyle;

  StepperWidgetAttributes({
    required this.instructions,
    required this.numberStyle,
  });

  StepperWidgetAttributes copyWith({
    final List<TextUIDataModel>? instructions,
    final PSTextStyleVariant? numberStyle,
  }) =>
      StepperWidgetAttributes(
        instructions: instructions ?? this.instructions,
        numberStyle: numberStyle ?? this.numberStyle,
      );
}
