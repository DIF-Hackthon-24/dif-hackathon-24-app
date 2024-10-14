import 'package:core/utils/extensions/string_extensions.dart';

class AmountFormatters{
  static String toFormattedAmount(double amount){
    return amount.toString().toStringAmountWithThousandSeparator().extractWholeAmount() ?? '';
  }

  static String toCurrencyFormat(String amount){
    return amount.toStringAmountWithThousandSeparator() ?? '';
  }
}