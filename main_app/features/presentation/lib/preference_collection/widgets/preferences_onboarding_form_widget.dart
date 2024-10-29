import 'package:core/qr_code/qr_code_scanner.dart';
import 'package:flutter/material.dart';
import 'package:shared_dependencies/constants/color_constants.dart';
import 'package:shared_dependencies/constants/dimension_constants.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:widget_library/input_text_view/form_text_field.dart';
import 'package:http/http.dart' as http;

class PreferencesOnboardingInputFormAttributes{
  Function submitButtonPressed;
  PreferencesOnboardingInputFormAttributes(
  { required this.submitButtonPressed});
}

class PreferencesOnboardingInputFormWidget extends StatefulWidget {
  final PreferencesOnboardingInputFormAttributes attributes;

  const PreferencesOnboardingInputFormWidget({
    Key? key,
    required this.attributes,
  }) : super(key: key);

  @override
  _PreferencesOnboardingInputFormWidgetState createState() =>
      _PreferencesOnboardingInputFormWidgetState(attributes);
}

class _PreferencesOnboardingInputFormWidgetState
    extends State<PreferencesOnboardingInputFormWidget> {
  final PreferencesOnboardingInputFormAttributes attributes;
  final TextEditingController textEditingController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  _PreferencesOnboardingInputFormWidgetState(this.attributes);

  // Static mapping of attributes
  final List<Map<String, dynamic>> userPreferences = [
    {'label': 'Room type', 'type': 'checkbox', 'options': ['Single', 'Double', 'Suite']},
    {'label': 'Smoking', 'type': 'checkbox'},
    {'label': 'Wheelchair Accessible', 'type': 'checkbox'},
    {'label': 'Breakfast Included', 'type': 'checkbox'},
    {'label': 'Spa services', 'type': 'checkbox', 'options': ['Massage', 'Facial', 'Manicure', 'Pedicure', 'General']},

  ];

  // State to hold checkbox values
  final Map<String, dynamic> checkboxValues = {};

  @override
  void initState() {
    super.initState();
    // Initialize checkbox values
    for (var attribute in userPreferences) {
      if (attribute['type'] == 'checkbox') {
        if (attribute.containsKey('options')) {
          checkboxValues[attribute['label']] = {};
          for (var option in attribute['options']) {
            checkboxValues[attribute['label']][option] = false;
          }
        } else {
          checkboxValues[attribute['label']] = false;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: DimensionConstants.size20,
        right: DimensionConstants.size20,
      ),
      child: Column(
        children: [
          Container(
            height: 700,
            decoration: BoxDecoration(
              border: Border.all(
                color: ColorConstants.COLOR_BLACK,
                width: DimensionConstants.size1,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(DimensionConstants.size4),
              ),
            ),
            child:
            ListView.builder(
              controller: scrollController,
              itemCount: userPreferences.length,
              itemBuilder: (context, index) {
                final attribute = userPreferences[index];
                if (attribute['type'] == 'text') {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: attribute['label'],
                        border: OutlineInputBorder(),
                      ),
                    ),
                  );
                } else if (attribute['type'] == 'checkbox') {
                  if (attribute.containsKey('options')) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0, left: 16.0),
                      child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 8.0),
                          child: Text(attribute['label'], style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                          )),
                        ),
                        ...attribute['options'].map<Widget>((option) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: CheckboxListTile(
                              title: Text(option, style: TextStyle(color: ColorConstants.COLOR_BLACK)),
                              value: checkboxValues[attribute['label']][option],
                              onChanged: (bool? value) {
                                setState(() {
                                  checkboxValues[attribute['label']][option] =
                                  value!;
                                });
                              },
                              activeColor: ColorConstants.COLOR_BLACK, // Set active color to black
                              checkColor: Colors.white,
                              side: BorderSide(color: ColorConstants.COLOR_BLACK, width: 2),
                            ),
                          );
                        }).toList(),
                      ],
                      )
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
                      child: CheckboxListTile(
                        title: Text(attribute['label'], style: TextStyle(color: ColorConstants.COLOR_BLACK, fontSize: 18,
                            fontWeight: FontWeight.bold)),
                        value: checkboxValues[attribute['label']],
                        onChanged: (bool? value) {
                          setState(() {
                            checkboxValues[attribute['label']] = value!;
                          });
                        },
                        activeColor: ColorConstants.COLOR_BLACK, // Set active color to black
                        checkColor: Colors.white,
                        side: BorderSide(color: ColorConstants.COLOR_BLACK, width: 2),
                      ),
                    );
                  }
                }
                return Container();
              },
            ),
          ),
          const SizedBox(
            height: DimensionConstants.size20,
          ),
          ElevatedButton(
            onPressed: () {
              print("Submit button pressed");
              attributes.submitButtonPressed.call();
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}



  // @override
  // Widget build(BuildContext context) {
  //   TextEditingController textEditingController = TextEditingController();
  //   ScrollController scrollController = ScrollController();
  //   return Padding(
  //     padding: const EdgeInsets.only(
  //       left: DimensionConstants.size20,
  //       right: DimensionConstants.size20,
  //     ),
  //     child: Column(
  //       children: [
  //         Container(
  //           height: DimensionConstants.size350,
  //           decoration: BoxDecoration(
  //             border: Border.all(
  //               color: ColorConstants.COLOR_FF188006,
  //               width: DimensionConstants.size1,
  //             ),
  //             borderRadius: const BorderRadius.all(
  //               Radius.circular(DimensionConstants
  //                   .size4), //                 <--- border radius here
  //             ),
  //           ),
  //           child: attributes.offerRequestData == ''
  //               ? QRCodeScanner(
  //             attributes: QRCodeScannerAttributes(onQrDetect: (capture) {
  //               final List<Barcode> barcodes = capture.barcodes;
  //               for (final barcode in barcodes) {
  //                 if (barcode.rawValue != '') {
  //                   attributes
  //                       .issueOfferRequestInputForm(barcode.rawValue!);
  //                 }
  //               }
  //             }),
  //           )
  //               : Text(attributes.offerRequestData),
  //         ),
  //         // Container(
  //         //   height: DimensionConstants.size180,
  //         //   decoration: BoxDecoration(
  //         //     border: Border.all(
  //         //       color: ColorConstants.COLOR_FF188006,
  //         //       width: DimensionConstants.size1,
  //         //     ),
  //         //     borderRadius: const BorderRadius.all(
  //         //       Radius.circular(DimensionConstants
  //         //           .size4), //                 <--- border radius here
  //         //     ),
  //         //   ),
  //         //   child: Scrollbar(
  //         //     controller: scrollController,
  //         //     child: FormTextField(
  //         //       maxLines: 6,
  //         //       backgroundColor: ColorConstants.COLOR_52E0E0E0,
  //         //       isRtl: true,
  //         //       controller: textEditingController,
  //         //       onSubmitted:
  //         //       attributes.issueOfferRequestInputForm,
  //         //       onChanged:
  //         //       attributes.issueOfferRequestInputForm,
  //         //       hint: "Please enter openid-credential-offer",
  //         //     ),
  //         //   ),
  //         // ),
  //         const SizedBox(
  //           height: DimensionConstants.size20,
  //         ),
  //         ElevatedButton(
  //           onPressed: () {
  //             attributes.offerRequestData == ''
  //                 ? null
  //                 : attributes.submitButtonPressed.call();
  //           },
  //           child: const Text('Submit'),
  //         ),
  //
  //       ],
  //     ),
  //   );
  // }
// }
