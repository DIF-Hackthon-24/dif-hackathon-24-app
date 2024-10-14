import 'package:flutter/material.dart';
import 'package:widget_library/common_widget/static_text/PSText.dart';
import 'package:widget_library/common_widget/stepper/stepper_widget_attributes.dart';

class StepperWidget extends StatelessWidget {
  final StepperWidgetAttributes attributes;

  StepperWidget({
    Key? key,
    required this.attributes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildListView();
  }

  Widget _buildListView() {
    final items = attributes.instructions;
    return Column(
      children: List<Widget>.generate(
        items.length,
        (index) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                PSText(
                  text: items[index].copyWith(
                    text: '${(index + 1).toString().padLeft(2, '0')}  ',
                    styleVariant: attributes.numberStyle,
                  ),
                ),
                Flexible(
                  child: PSText(
                    text: items[index],
                  ),
                ),
              ],
            ),
            if (index < items.length - 1)
              Padding(
                padding: EdgeInsets.only(top: 5, bottom: 5, left: 10),
                child: SizedBox(
                  height: 16,
                  width: 1,
                  child: Container(
                    color: Colors.grey,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
