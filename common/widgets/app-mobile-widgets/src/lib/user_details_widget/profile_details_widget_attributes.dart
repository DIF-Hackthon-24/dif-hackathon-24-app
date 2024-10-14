class ProfileDetailsWidgetAttributes {
  UserUIModel? model;
  String? nameLabel;
  String? nameTextLabel;
  String? logoutTextLabel;
  String? languageTextLabel;
  String? personalDetailsTextLabel;
  String? myApplicationsTextLabel;
  ProfileButtonAttributes? profileButtonAttributes;
  bool? isProfileExist;
  bool? isRTL;
  bool? isNEProfile;

  ProfileDetailsWidgetAttributes({
    this.model,
    this.nameLabel,
    this.nameTextLabel,
    this.languageTextLabel,
    this.logoutTextLabel,
    this.personalDetailsTextLabel,
    this.myApplicationsTextLabel,
    this.profileButtonAttributes,
    this.isProfileExist, 
    this.isRTL,
    this.isNEProfile,
  });
}

class UserUIModel {
  String? displayName;
  String? image;

  UserUIModel({
    this.displayName,
    this.image,
  });
}

class ProfileButtonAttributes {
  Function(String code) onLanguagePressed;
  Function onLogOutPressed;
  Function onProfilePressed;
  Function onMyApplicationsPressed;
  Function onProfileAlertPressed;

  ProfileButtonAttributes({
    required this.onLanguagePressed,
    required this.onLogOutPressed,
    required this.onProfilePressed,
    required this.onMyApplicationsPressed,
    required this.onProfileAlertPressed,
  });
}

