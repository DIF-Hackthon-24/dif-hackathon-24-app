class IntroViewDataModel {
  final IntroMode mode;
  final String? nextScreenNavigation;
  final Map<String, Object>? nextScreenArguments;
  final bool? fastTrack;
  final List<String> documentsToCollect;

  IntroViewDataModel({
    this.nextScreenNavigation,
    this.nextScreenArguments,
    this.mode = IntroMode.business,
    this.fastTrack,
    this.documentsToCollect = const [],
  });
}

enum IntroMode { business, freelancer }
