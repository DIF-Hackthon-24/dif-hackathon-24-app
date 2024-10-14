import 'package:flutter/services.dart';

class AmountInputFormatter extends TextInputFormatter{
  final double maxAmount;
   AmountInputFormatter({required this.maxAmount});
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
     if(newValue.text == '') return newValue;
     if(double.parse(newValue.text.toString()) <= maxAmount){
       return newValue;
     }
     return oldValue;
  }

}