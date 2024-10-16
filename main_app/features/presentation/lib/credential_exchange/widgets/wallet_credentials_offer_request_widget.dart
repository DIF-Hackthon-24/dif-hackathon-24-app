import 'package:core/qr_code/qr_code_scanner.dart';
import 'package:flutter/material.dart';
import 'package:shared_dependencies/constants/color_constants.dart';
import 'package:shared_dependencies/constants/dimension_constants.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

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
          const SizedBox(
            height: DimensionConstants.size100,
          ),
          ElevatedButton(
            onPressed: () {
              attributes.offerRequestData == ''
                  ? null
                  : attributes.submitButtonPressed.call();
            },
            child: const Text('Submit'),
          )
        ],
      ),
    );
  }
}
