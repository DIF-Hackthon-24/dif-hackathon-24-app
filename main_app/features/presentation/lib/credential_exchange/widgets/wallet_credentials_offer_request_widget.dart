import 'package:core/qr_code/qr_code_scanner.dart';
import 'package:flutter/material.dart';
import 'package:shared_dependencies/constants/color_constants.dart';
import 'package:shared_dependencies/constants/dimension_constants.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:widget_library/input_text_view/form_text_field.dart';

class CredentialOfferInputFormAttributes {
  String offerRequestData;
  ValueSetter<String> issueOfferRequestInputForm;
  Function submitButtonPressed;
  CredentialOfferInputFormAttributes(
      {required this.offerRequestData,
        required this.issueOfferRequestInputForm,
        required this.submitButtonPressed});
}

class CredentialOfferInputFormWidget extends StatelessWidget {
  final CredentialOfferInputFormAttributes attributes;

  const CredentialOfferInputFormWidget({
    Key? key,
    required this.attributes,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();
    ScrollController scrollController = ScrollController();
    return Padding(
      padding: const EdgeInsets.only(
        left: DimensionConstants.size20,
        right: DimensionConstants.size20,
      ),
      child: Column(
        children: [
          Container(
            height: DimensionConstants.size350,
            decoration: BoxDecoration(
              border: Border.all(
                color: ColorConstants.COLOR_FF188006,
                width: DimensionConstants.size1,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(DimensionConstants
                    .size4), //                 <--- border radius here
              ),
            ),
            child: attributes.offerRequestData == ''
                ? QRCodeScanner(
              attributes: QRCodeScannerAttributes(onQrDetect: (capture) {
                final List<Barcode> barcodes = capture.barcodes;
                for (final barcode in barcodes) {
                  if (barcode.rawValue != '') {
                    attributes
                        .issueOfferRequestInputForm(barcode.rawValue!);
                  }
                }
              }),
            )
                : Text(attributes.offerRequestData),
          ),

          // Container(
          //   height: DimensionConstants.size180,
          //   decoration: BoxDecoration(
          //     border: Border.all(
          //       color: ColorConstants.COLOR_FF188006,
          //       width: DimensionConstants.size1,
          //     ),
          //     borderRadius: const BorderRadius.all(
          //       Radius.circular(DimensionConstants
          //           .size4), //                 <--- border radius here
          //     ),
          //   ),
          //   child: Scrollbar(
          //     controller: scrollController,
          //     child: FormTextField(
          //       maxLines: 6,
          //       backgroundColor: ColorConstants.COLOR_52E0E0E0,
          //       isRtl: true,
          //       controller: textEditingController,
          //       onSubmitted:
          //       attributes.issueOfferRequestInputForm,
          //       onChanged:
          //       attributes.issueOfferRequestInputForm,
          //       hint: "Please enter openid-credential-offer",
          //     ),
          //   ),
          // ),
          const SizedBox(
            height: DimensionConstants.size20,
          ),
          ElevatedButton(
            onPressed: () {
              attributes.offerRequestData == ''
                  ? null
                  : attributes.submitButtonPressed.call("offer_request_acceptance");
            },
            child: const Text('Offer Request Acceptance'),
          ),

          const SizedBox(
            height: DimensionConstants.size10,
          ),
          ElevatedButton(
            onPressed: () {
              attributes.offerRequestData == ''
                  ? null
                  : attributes.submitButtonPressed.call("verify_credential_id");
            },
            child: const Text('Verify Credential IDs'),
          ),
          const SizedBox(
            height: DimensionConstants.size10,
          ),
          ElevatedButton(
            onPressed: () {
              attributes.offerRequestData == ''
                  ? null
                  : attributes.submitButtonPressed.call("process_presentation");
            },
            child: const Text('Process Presentation'),
          )
        ],
      ),
    );
  }
}
