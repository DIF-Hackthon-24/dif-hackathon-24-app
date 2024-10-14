import 'package:core/utils/input_formatters/mask_formatter.dart';

class EmiratesIdFormatter extends MaskTextInputFormatter {
  EmiratesIdFormatter() : super(mask: '###-####-#######-#', filter: {'#': RegExp(r'[0-9]')});
}
