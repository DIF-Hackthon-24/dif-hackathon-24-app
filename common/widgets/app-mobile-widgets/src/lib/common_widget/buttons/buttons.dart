enum PSButtonType {
  backArrow,
  docked,
  inPage,
  linked,
  rounded,
}

/// The possible button themes
enum PSButtonThemeVariant { primary, secondary, tertiary, quaternary }

/// The possible button styles supported
/// This is specific to PSInPageButton
enum PSButtonOverlayStyle {
  rectangular,
  rounded,
  roundedOutlined,
  rectangularOutlined,
}

// ButtonColorAttributes getVariantColorScheme(
//   PSThemeData theme,
//   PSButtonThemeVariant variant,
// ) {
//   ButtonColorAttributes colourScheme;
//   switch (variant) {
//     case PSButtonThemeVariant.secondary:
//       colourScheme = theme.colorStyles.buttonColors.secondary;
//       break;
//     case PSButtonThemeVariant.tertiary:
//       colourScheme = theme.colorStyles.buttonColors.tertiary;
//       break;
//     case PSButtonThemeVariant.quaternary:
//       colourScheme = theme.colorStyles.buttonColors.quaternary;
//       break;
//     default:
//       colourScheme = theme.colorStyles.buttonColors.primary;
//   }
//   return colourScheme;
// }
