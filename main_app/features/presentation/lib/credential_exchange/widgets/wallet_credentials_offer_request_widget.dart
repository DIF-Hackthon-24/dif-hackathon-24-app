import 'package:flutter/material.dart';
import 'package:shared_dependencies/constants/color_constants.dart';
import 'package:shared_dependencies/constants/dimension_constants.dart';
import 'package:widget_library/input_text_view/form_text_field.dart';

class CredentialOfferInputFormAttributes {
  ValueSetter<String> issueOfferRequestInputForm;
  Function submitButtonPressed;
  CredentialOfferInputFormAttributes({required this.issueOfferRequestInputForm, required this.submitButtonPressed});
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
    const radius = Radius.circular(DimensionConstants.size22);
    return Container(
      height: (MediaQuery.of(context).size.height),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: radius,
        ),
        color: ColorConstants.COLOR_WHITE,
      ),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: DimensionConstants.size20,
                      right: DimensionConstants.size20,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: DimensionConstants.size180,
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
                          child: Scrollbar(
                            controller: scrollController,
                            child: FormTextField(
                              maxLines: 6,
                              backgroundColor: ColorConstants.COLOR_52E0E0E0,
                              isRtl: true,
                              controller: textEditingController,
                              onSubmitted:
                              attributes.issueOfferRequestInputForm,
                              onChanged: attributes.issueOfferRequestInputForm,
                              hint: "Please enter openid-credential-offer",
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: DimensionConstants.size100,
                        ),
                        ElevatedButton(
                          onPressed: (){
                            attributes.submitButtonPressed.call();
                          },
                          child: const Text('Submit'),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
