
import 'package:core/navigation/navigation_manager.dart';
import 'package:core/translation/app_localization.dart';
import 'package:core/utils/extensions/iterable_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:widget_library/common_widget/page_header/text_ui_data_model.dart';
import 'package:widget_library/common_widget/static_text/PSText.dart';
import 'package:widget_library/ps_scaffold.dart';

enum PSAppBarButtons {
  back,
  backArabic,
  menu,
  search,
  close,
  share,
  more,
  skip,
  login,
  signup,
  info,
  change,
  custom,
}

class _Constants {
  static const double marginWidth = 20;
  static const backButtonAccessibility = 'Back';
}

class PSAppBarButtonAttributes {
  PSAppBarButtons type;
  TextStyle? textStyle;
  void Function()? onPressed;
  double? iconSize = 36;
  Widget? customItem;

  PSAppBarButtonAttributes({
    required this.type,
    this.textStyle,
    this.onPressed,
    this.iconSize,
    this.customItem,
  });
}

class PSAppBarAttributes {
  String? title;
  List<PSAppBarButtonAttributes>? left;
  List<PSAppBarButtonAttributes>? right;
  Widget? subWidgets;
  PSBrightness brightness;

  PSAppBarAttributes({
    this.title,
    this.left,
    this.right,
    this.subWidgets,
    this.brightness = PSBrightness.light,
  });

  PSAppBarAttributes copyWith({
    String? title,
    List<PSAppBarButtonAttributes>? left,
    List<PSAppBarButtonAttributes>? right,
    Widget? subWidget,
  }) =>
      PSAppBarAttributes(
        title: title ?? this.title,
        left: left ?? this.left,
        right: right ?? this.right,
        subWidgets: subWidgets ?? subWidgets,
      );
}

void _handleAppBarButtonClick(PSAppBarButtons type) {
  switch (type) {
    case PSAppBarButtons.back:
    case PSAppBarButtons.backArabic:
    case PSAppBarButtons.close:
      NavigationManager.goBack();
      break;
    default:
      break;
  }
}

Widget _getIcon(
  BuildContext context,
  PSAppBarButtonAttributes attributes,
  Color color,
  bool isRight,
) {
  switch (attributes.type) {
    case PSAppBarButtons.back:
      return Semantics(
        label: _Constants.backButtonAccessibility,
        child: SvgPicture.asset(
          'assets/images/back_arrow.svg',
          key: Key('SvgPicture'),
          package: 'widget_library',
          colorFilter: ColorFilter.mode(
            color,
            BlendMode.srcIn,
          ),
          // color: color,
          height: attributes.iconSize,
          width: attributes.iconSize,
        ),
      );

    case PSAppBarButtons.backArabic:
      return SvgPicture.asset(
        'assets/images/back_right_arrow.svg',
        key: Key('SvgPicture'),
        package: 'widget_library',
        // color: color,
        colorFilter: ColorFilter.mode(
          color,
          BlendMode.srcIn,
        ),
        height: attributes.iconSize,
        width: attributes.iconSize,
      );

    case PSAppBarButtons.close:
      return Icon(
        Icons.close,
        key: Key('PSAppBarButtons_CloseIcon'),
        color: color,
        size: attributes.iconSize,
      );

    case PSAppBarButtons.menu:
      return Icon(Icons.menu, key: Key('PSAppBarButtons_MenuIcon'), color: color);

    case PSAppBarButtons.more:
      return Icon(Icons.more_horiz_sharp, key: Key('PSAppBarButtons_Horiz_sharpIcon'), color: color);

    case PSAppBarButtons.search:
      return Icon(Icons.search, key: Key('PSAppBarButtons_SearchIcon'), color: color);

    case PSAppBarButtons.share:
      return Icon(Icons.ios_share, key: Key('PSAppBarButtons_ShareIcon'), color: color);

    case PSAppBarButtons.info:
      return Icon(Icons.info_outline_rounded, key: Key('PSAppBarButtons_InfoIcon'), color: color);

    case PSAppBarButtons.skip:
      return Center(
        child: PSText(
          text: TextUIDataModel(
            'account:create_saving_space_skip',
            styleVariant: PSTextStyleVariant.headline6,
          ),
        ),
      );
    case PSAppBarButtons.login:
      return Center(
        child: PSText(
          text: TextUIDataModel(
            'login:login_login',
            styleVariant: PSTextStyleVariant.headline6,
          ),
        ),
      );
    case PSAppBarButtons.signup:
      return Center(
        child: PSText(
          text: TextUIDataModel(
            'login:signup_signup',
            styleVariant: PSTextStyleVariant.headline6,
          ),
        ),
      );

    case PSAppBarButtons.change:
      return Center(
        child: PSText(
          text: TextUIDataModel(
            'login:change_user',
            styleVariant: PSTextStyleVariant.headline6,
          ),
        ),
      );
    default:
      return Container(
        key: Key('PSAppBarButtons_NullContainer'),
      );
  }
}

List<Widget> _createAppBarButtons(
  List<PSAppBarButtonAttributes> buttonAttributesList, {
  required BuildContext context,
  bool isRight = false,
  ThemeData? theme,
}) {
  final mainTheme = theme ?? Theme.of(context);
  final color = isRight ? mainTheme.appBarTheme.actionsIconTheme?.color : mainTheme.appBarTheme.iconTheme?.color;
  var buttons = buttonAttributesList.mapIndexed(
    (item, index) {
      if(item.customItem != null){
        return item.customItem!;
      }
      return Container(
        key: Key('createAppBarButtons_Container$index'),
        child: GestureDetector(
          key: Key('createAppBarButtons_GestureDetector$index'),
          onTap: (item.onPressed != null)
              ? item.onPressed!
              : () {
                  _handleAppBarButtonClick(
                    item.type,
                  );
                },
          child: _getIcon(
            context,
            item,
            color ?? mainTheme.appBarTheme.foregroundColor!,
            isRight,
          ),
        ),
      );
    },
  ).toList();
  final spacer = Container(
    key: Key('createAppBarButtons_ContainerWidth_'),
    width: _Constants.marginWidth,
  );
  if (isRight) {
    buttons.add(spacer);
  } else {
    buttons.insert(0, spacer);
  }
  return buttons;
}

PreferredSizeWidget psDefaultAppBar(
  BuildContext context,
  PSAppBarAttributes attributes,
  ThemeData theme,
) {
  final assumedIconWidth = 30.0;
  final leadingWidth = _Constants.marginWidth + (assumedIconWidth * (attributes.left?.length ?? 0.0));
  return AppBar(
    key: Key('psDefaultAppBar_AppBar'),
    centerTitle: true,
    automaticallyImplyLeading: false,
    //brightness: attributes.brightness == PSBrightness.dark ? Brightness.dark : Brightness.light,
    leading: (attributes.left != null)
        ? Row(
            key: Key('psDefaultAppBar_Row'),
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: _createAppBarButtons(
              attributes.left ?? [],
              context: context,
              theme: theme,
            ),
          )
        : null,
    leadingWidth: leadingWidth,
    title: _createTitle(
      context,
      attributes,
      theme,
    ),
    actions: (attributes.right != null)
        ? _createAppBarButtons(
            attributes.right!,
            context: context,
            isRight: true,
            theme: theme,
          )
        : null,
    elevation: 0,
  );
}

Widget _createTitle(
  BuildContext context,
  PSAppBarAttributes attributes,
  ThemeData theme,
) {
  if (attributes.title != null) {
    final language = Localizations.localeOf(context).languageCode;
    return FittedBox(
      key: Key('createTitle_FittedBox'),
      child: ConstrainedBox(
        constraints: BoxConstraints(minWidth: 1, minHeight: 1),
        child: Text(
          AppLocalizations.of(context)!.translate(attributes.title!),
          key: Key('createTitle_Text'),
          style: theme.appBarTheme.titleTextStyle!.copyWith(
            fontSize: 18,
            fontFamily: language == 'ar'
                ? '${theme.appBarTheme.titleTextStyle!.fontFamily}Arabic'
                : theme.appBarTheme.titleTextStyle!.fontFamily,
          ),
        ),
      ),
    );
  }
  return Container(key: Key('createTitle_Container'));
}
