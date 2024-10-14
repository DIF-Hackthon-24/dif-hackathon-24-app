import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class _Constants{
  static const arabicNumbers = [
    '٠',
    '١',
    '٢',
    '٣',
    '٤',
    '٥',
    '٦',
    '٧',
    '٨',
    '٩',
    '؟',
    '،',
    '؛',
    'و'
  ];
}

class TextOnlyInputFormatter extends TextInputFormatter{
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final onlyTextValue = isArabicNumber(newValue.text);
     if(!onlyTextValue) {
      return newValue;
      }
     else{
     return oldValue;
     }
  }

  bool isArabicNumber(String enteredText){
    final isNumber = enteredText.characters.where((element) => _Constants.arabicNumbers.contains(element)).toList();
    return isNumber.isNotEmpty;
  }

}