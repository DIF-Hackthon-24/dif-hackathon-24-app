class UserDetailsWidgetAttributes {
  String? description;
  UserUIModel? model;
  List<BottomButtonAttributes>? bottomButtonAttributes;
  String? nameLabel;
  String? nameTextLabel;
  String? contactNumberLabel;
  String? emiratesIdLabel;
  bool? displayProfileScreen;

  UserDetailsWidgetAttributes({
    this.model,
    this.description,
    this.contactNumberLabel,
    this.emiratesIdLabel,
    this.nameLabel,
    this.nameTextLabel,
    this.bottomButtonAttributes = const [],
    this.displayProfileScreen,
  });
}

class UserUIModel {
  String? userName;
  String? phoneNumber;
  String? emiratesId;
  String? displayName;
  String? image;

  UserUIModel({
    this.emiratesId,
    this.phoneNumber,
    this.userName,
    this.displayName,
    this.image,
  });
}

class BottomButtonAttributes {
  String text;
  Function onPressed;

  BottomButtonAttributes({
    required this.text,
    required this.onPressed,
  });
}
