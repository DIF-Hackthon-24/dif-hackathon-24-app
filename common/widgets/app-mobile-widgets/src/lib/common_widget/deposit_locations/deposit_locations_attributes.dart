import 'package:widget_library/common_widget/card/view_card_detail/model/card_detail_bottom_sheet_model.dart';
import 'package:widget_library/common_widget/page_header/text_ui_data_model.dart';

// @immutable
class DepositLocationsAttributes {
  final CardRowHeaderModel? depositLocationsCardHeaderText;
  final TextUIDataModel? depositorDetails;
  final TextUIDataModel? thePersonWillAuthorized;
  final int? venueLocationIndex;
  Function(int index)? venueListCallBack;
  final Set<String> depositLocationVenueList;
  final List<DropBoxLocation>? locations;
  Function(DropBoxLocation? location)? onLocationSelect;

  DepositLocationsAttributes({
    required this.depositLocationsCardHeaderText,
    required this.venueLocationIndex,
    required this.depositLocationVenueList,
    this.depositorDetails,
    this.thePersonWillAuthorized,
    this.venueListCallBack,
    this.locations,
    this.onLocationSelect,
  });

  DepositLocationsAttributes copyWith({
    final CardRowHeaderModel? depositLocationsCardHeaderText,
    TextUIDataModel? depositorDetails,
    TextUIDataModel? thePersonWillAuthorized,
    int? venueLocationIndex,
    Function(int otpText)? venueListCallBack,
    Set<String>? depositLocationVenueList,
    List<DropBoxLocation>? locations,
    Function(DropBoxLocation? location)? onLocationSelect,
  }) =>
      DepositLocationsAttributes(
        depositLocationsCardHeaderText: depositLocationsCardHeaderText ?? this.depositLocationsCardHeaderText,
        venueLocationIndex: venueLocationIndex ?? this.venueLocationIndex,
        depositorDetails: depositorDetails ?? this.depositorDetails,
        thePersonWillAuthorized: thePersonWillAuthorized ?? this.thePersonWillAuthorized,
        venueListCallBack: venueListCallBack ?? this.venueListCallBack,
        depositLocationVenueList: depositLocationVenueList ?? this.depositLocationVenueList,
        locations: locations ?? this.locations,
        onLocationSelect: onLocationSelect ?? this.onLocationSelect,
      );
}

class DropBoxLocation {
  final String? code;
  final String? region;
  final String? location;
  final String? googleMapsLink;
  final String? chequeDeposit;
  final String? cashDeposit;
  final String? cashWithdrawal;
  final String? address;
  final String? optionalField;

  DropBoxLocation({
    this.code,
    this.region,
    this.location,
    this.googleMapsLink,
    this.chequeDeposit,
    this.cashDeposit,
    this.cashWithdrawal,
    this.address,
    this.optionalField,
  });
}
