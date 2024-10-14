import 'package:core/app/ps_material_app.dart';
import 'package:core/navigation/navigation_manager.dart';
import 'package:core/translation/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:widget_library/common_widget/page_header/text_ui_data_model.dart';
import 'package:widget_library/common_widget/static_text/PSText.dart';
import 'package:widget_library/common_widget/theme/ps_theme.dart';
import 'package:widget_library/common_widget/transaction_list/transaction_list.dart';
import 'package:widget_library/common_widget/transaction_list/transaction_list_item.dart';
import 'package:widget_library/common_widget/transaction_list/transaction_status_tag.dart';
import 'package:widget_library/ps_scaffold.dart';

final List<String> supportedLanguangeCode = ['en', 'ar'];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PSTheme().initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp();

  @override
  // ignore: long-method
  Widget build(BuildContext context) {
    AppLocalizations.localeList = supportedLanguangeCode;

    return PSMaterialApp(
      theme: PSTheme().defaultTheme,
      onGenerateRoute: NavigationManager.getRoute,
      routes: {},
      home: DemoContent(),
      supportedLocales: [
        Locale('en'),
        Locale('ar'),
      ],
      localizationsDelegates: [
        AppLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        // Check if the current device locale is supported
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale!.languageCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
    );
  }
}

class DemoContent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DemoContentState();
}

class _DemoContentState extends State<DemoContent> with SingleTickerProviderStateMixin {
  late String _currentThemeName;

  final amountFocusNode = FocusNode();

  @override
  void initState() {
    amountFocusNode.addListener(_focusListener);
    _currentThemeName = 'default';
    super.initState();
  }

  @override
  void dispose() {
    amountFocusNode.removeListener(_focusListener);
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return PSScaffold(
      themeName: _currentThemeName,
      body: SafeArea(
        child: Column(
          children: [
            Text('Transaction list'),
            Expanded(
              child: CustomScrollView(
                slivers: [
                  TransactionList(
                    transactionListAttributes: TransactionListAttributes(
                      actions: [],
                      showActions: false,
                      groupedTransactions: {
                        DateTime.fromMillisecondsSinceEpoch(1636236000000000): [
                          TransactionItemAttributes(
                            amount: TextUIDataModel(
                              '-50 00 000',
                              styleVariant: PSTextStyleVariant.transactionRowAmount,
                              textAlign: TextAlign.start,
                            ),
                            date: '07-11-2021 13:45:47',
                            logoType: 'app_account:assets/icons/ic_inbound.svg',
                            title: TextUIDataModel(
                              'Cash withdrawal at Al Wahda Mall - Lulu Exchange',
                              styleVariant: PSTextStyleVariant.transactionRowTitle,
                              textAlign: TextAlign.start,
                            ),
                            subtitle: TextUIDataModel(
                              'Withdrawer: Luca Esposito ',
                              styleVariant: PSTextStyleVariant.transactionRowSubTitle,
                              textAlign: TextAlign.start,
                            ),
                            tagColor: TagColor.cancelled,
                            tagText: TextUIDataModel(
                              'Cancelled',
                              styleVariant: PSTextStyleVariant.tag,
                            ),
                            withdrawer: TextUIDataModel(
                              'Withdrawal',
                              styleVariant: PSTextStyleVariant.tag,
                            ),
                            onItemTap: () {},
                          ),
                          TransactionItemAttributes(
                            amount: TextUIDataModel(
                              '-50 00 000',
                              styleVariant: PSTextStyleVariant.transactionRowAmount,
                              textAlign: TextAlign.start,
                            ),
                            date: '07-11-2021 13:45:47',
                            logoType: 'app_account:assets/icons/ic_inbound.svg',
                            title: TextUIDataModel(
                              'Cash withdrawal at Al Wahda Mall - Lulu Exchange',
                              styleVariant: PSTextStyleVariant.transactionRowTitle,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                            ),
                            tagColor: TagColor.pending,
                            tagText: TextUIDataModel(
                              'Pending',
                              styleVariant: PSTextStyleVariant.tag,
                            ),
                            onItemTap: () {},
                          ),
                          TransactionItemAttributes(
                            amount: TextUIDataModel(
                              '-50 00 000',
                              styleVariant: PSTextStyleVariant.transactionRowAmount,
                              textAlign: TextAlign.start,
                            ),
                            date: '07-11-2021 13:45:47',
                            logoType: 'app_account:assets/icons/ic_inbound.svg',
                            title: TextUIDataModel(
                              'Cash withdrawal at Al Wahda Mall - Lulu Exchange',
                              styleVariant: PSTextStyleVariant.transactionRowTitle,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                            ),
                            tagColor: TagColor.cancelled,
                            tagText: TextUIDataModel(
                              'Cancelled',
                              styleVariant: PSTextStyleVariant.tag,
                            ),
                            completed: false,
                            onItemTap: () {},
                          ),
                          TransactionItemAttributes(
                            amount: TextUIDataModel(
                              '-50 00 000',
                              styleVariant: PSTextStyleVariant.transactionRowAmount,
                              textAlign: TextAlign.start,
                            ),
                            date: '07-11-2021 13:45:47',
                            logoType: 'app_account:assets/icons/ic_inbound.svg',
                            title: TextUIDataModel(
                              'Cash withdrawal 1 line',
                              styleVariant: PSTextStyleVariant.transactionRowTitle,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                            ),
                            tagColor: TagColor.cancelled,
                            tagText: TextUIDataModel(
                              'Cancelled',
                              styleVariant: PSTextStyleVariant.tag,
                            ),
                            completed: false,
                            onItemTap: () {},
                          ),
                        ],
                      },
                      yesterdayLocale: 'account:yesterday',
                      transactionTitleLocale: 'account:transaction_transactions',
                      todayLocale: 'account:today',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _focusListener() => print('amount field focused: ${amountFocusNode.hasFocus}');
}
