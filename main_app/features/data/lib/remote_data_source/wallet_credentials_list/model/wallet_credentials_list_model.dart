
import 'package:network_manager/utils/connectivity/jwt_parser.dart';

class WalletCredentialListModel{
  List<WalletCredentialModel>? walletCredentials;
  WalletCredentialListModel({this.walletCredentials});
  WalletCredentialListModel.fromJson(List<dynamic> json) {
    walletCredentials = json.map((obj)=>WalletCredentialModel.fromJson(obj)).toList();
  }
}


class WalletCredentialModel {
  String? wallet;
  String? id;
  Map<String, dynamic>?  document;
  String? disclosures;
  String? addedOn;
  String? format;
  String? deletedOn;

  WalletCredentialModel(
      {this.wallet,
        this.id,
        this.document,
        this.disclosures,
        this.addedOn,
        this.format,
      this.deletedOn});

  WalletCredentialModel.fromJson(Map<String, dynamic> json) {
    wallet = json['wallet'];
    id = json['id'];
    document = Jwt.parseJwt(json['document']);
    disclosures = json['disclosures'];
    addedOn = json['addedOn'];
    format = json['format'];
    deletedOn = json['deletedOn'];
  }



  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['wallet'] = wallet;
    data['id'] = id;
    data['document'] = document;
    data['disclosures'] = disclosures;
    data['addedOn'] = addedOn;
    data['format'] = format;
    data['deletedOn'] = deletedOn;
    return data;
  }
}

class ProcessResponseModel {
  final String? redirectUri;

  ProcessResponseModel({this.redirectUri});

  // Factory constructor to create an instance from a JSON map
  factory ProcessResponseModel.fromJson(Map<String, dynamic> json) {
    return ProcessResponseModel(
      redirectUri: json['redirectUri'] as String?,
    );
  }

  // Method to convert an instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'redirectUri': redirectUri,
    };
  }
}