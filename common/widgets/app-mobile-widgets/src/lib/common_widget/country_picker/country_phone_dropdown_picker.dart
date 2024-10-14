import 'package:core/navigation/navigation_manager.dart';
import 'package:core/utils/extensions/string_extensions.dart';
import 'package:country_pickers/countries.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:widget_library/common_widget/country_picker/country_phone_form_field.dart';
import 'package:widget_library/common_widget/image/image_widget.dart';
import 'package:widget_library/common_widget/page_header/text_ui_data_model.dart';
import 'package:widget_library/common_widget/search_bar/search_bar_widget.dart';
import 'package:widget_library/common_widget/search_bar/search_bar_widget_model.dart';
import 'package:widget_library/common_widget/static_text/PSText.dart';
import 'package:widget_library/common_widget/theme/ps_theme.dart';

class _Constant {
  static const double tenPixels = 10;
  static const double containerHeight = 652.0;
  static const double thirtyTwoPixels = 32;
  static const double closeIconSize = 28;
  static const double twentyFourPixels = 24;
  static const int debounceDuration = 200;
  static const double eightPixels = 8.0;
  static const validationIconPath = 'widget_library:assets/images/ic_validation_success.svg';
  static const allPrefixText = 'invoice:bottomSheet_all_prefixes';
  static const searchIconPath = 'widget_library:assets/images/search.svg';
  static const searchLabel = 'invoice:bottomSheet_search_country';
  static const closeIconPath = 'app_mobile_login:assets/images/ic_close.svg';
  static const selectPrefixText = 'invoice:bottomSheet_select_prefix';
}

// ignore: must_be_immutable
class CountryPhoneDropdownPicker extends StatefulWidget {
  CountryPhoneFormField attributes;
  CountryPhoneDropdownPicker({
    Key? key,
    required this.attributes,
  }) : super(key: key);

  @override
  _CountryPhoneDropdownPickerState createState() => _CountryPhoneDropdownPickerState();
}

class _CountryPhoneDropdownPickerState extends State<CountryPhoneDropdownPicker> {
  final countryInstanceList = List<Country>.from(countryList);

  @override
  Widget build(
    BuildContext context,
  ) {
    final theme = Theme.of(context);
    return Container(
      color: Colors.transparent,
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        height: _Constant.containerHeight,
        margin: EdgeInsets.all(_Constant.thirtyTwoPixels),
        child: Builder(
          builder: (BuildContext context) => StatefulBuilder(builder: (
            context,
            setStateModal,
          ) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PSText(
                      text: TextUIDataModel(
                        _Constant.selectPrefixText,
                        styleVariant: PSTextStyleVariant.headline4,
                      ),
                    ),
                    IconButton(
                      icon: PSImage(
                        PSImageModel(
                          iconPath: _Constant.closeIconPath,
                          height: _Constant.closeIconSize,
                          width: _Constant.closeIconSize,
                        ),
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: _Constant.twentyFourPixels),
                  child: SearchBarWidget(
                    attributes: SearchBarAttributes(
                      dataModel: SearchBarDataModel(
                        hint: _Constant.searchLabel,
                        variant: PSTextStyleVariant.subtitle2,
                      ),
                      appearance: SearchBarAppearance(
                        backgroundColor: PSTheme().themeData.colorPalette!.panelColorPrimary.toColor(),
                        cornerRadius: _Constant.tenPixels,
                        suffixIcon: _Constant.searchIconPath,
                      ),
                    ),
                    onSearch: (value) {
                      _onSearchInput(value, setStateModal);
                    },
                    debounceDuration: _Constant.debounceDuration,
                    onTextChanged: (value) {
                      _onSearchInput(value, setStateModal);
                    },
                  ),
                ),
                _ListHeader(_Constant.allPrefixText),
                Expanded(
                  child: ListView.separated(
                    key: Key('countries-${countryInstanceList.length}'),
                    itemBuilder: (context, index) {
                      return _buildDropdownItem(
                        theme.textTheme.bodyLarge,
                        countryInstanceList[index],
                      );
                    },
                    separatorBuilder: (context, index) => Divider(
                      thickness: 1,
                    ),
                    itemCount: countryInstanceList.length,
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _buildDropdownItem(
    TextStyle? style,
    Country country,
  ) {
    return InkWell(
      onTap: () {
        widget.attributes.onValuePicked?.call(country.isoCode);
        widget.attributes.selectedCountry = country;
        NavigationManager.goBack();
      },
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 5),
        leading: CountryPickerUtils.getDefaultFlagImage(country),
        title: Text(
          '+${country.phoneCode}',
          key: Key('CountryPhoneFormField_buildDropdownItemText_${country.name}'),
          style: style,
        ),
        trailing: widget.attributes.selectedCountry == country
            ? PSImage(
                PSImageModel(iconPath: _Constant.validationIconPath),
              )
            : null,
      ),
    );
  }

  void _onSearchInput(String predicate, StateSetter setStateModal) {
    countryInstanceList.clear();
    if (predicate.isNotEmpty) {
      var countryListCopy = List<Country>.from(countryList);
      countryListCopy =
          countryListCopy.where((element) => element.name.toLowerCase().contains(predicate.toLowerCase())).toList();
      setStateModal(() {
        countryInstanceList.addAll(countryListCopy);
      });
    } else {
      setStateModal(() {
        countryInstanceList.addAll(countryList);
      });
    }
  }
}

class _ListHeader extends StatelessWidget {
  const _ListHeader(this.title);

  final String title;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: _Constant.eightPixels),
        child: PSText(
          text: TextUIDataModel(title, styleVariant: PSTextStyleVariant.bodyText2),
        ),
      );
}
