import 'package:widget_library/common_widget/square_panel_detail/square_panel_detail_attributes.dart';

abstract class SquarePanelAttributes {
  final String title;
  Stream<double>? streamProgress;
  final String? infoIconPath;
  final String uploadIconPath;
  bool isSelected;
  String subtitle;
  final List<SquarePanelDetailAttributes> children;
  Function? onTap;
  Function? onInfoTap;
  final String progressCompletedLabel;
  final String squarePanelTheme;

  final String? topRightChipLabel;

  SquarePanelAttributes({
    required this.children,
    required this.title,
    required this.streamProgress,
    required this.infoIconPath,
    required this.uploadIconPath,
    required this.isSelected,
    required this.subtitle,
    this.onTap,
    this.onInfoTap,
    required this.progressCompletedLabel,
    this.squarePanelTheme = 'onboarding',
    this.topRightChipLabel,
  });
}
