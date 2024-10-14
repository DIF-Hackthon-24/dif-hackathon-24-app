import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

const _decimalSeparator = '.';
final _decimalCountMatcher = RegExp(r'\.\d{3}$');

/// Formats input value to
/// 1
/// 1,234
/// 1,234,567.10
/// 1,234,567.12
class CurrencyInputFormatter extends TextInputFormatter {
  ///The maximum of digits in whole number part
  ///that user can enter
  final int? maximumLengthOfWholeNumberPart;
  CurrencyInputFormatter({this.maximumLengthOfWholeNumberPart});

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0 && newValue.text.isEmpty) {
      return newValue;
    }

    var allChars = newValue.text.characters.where((it) => (it == _decimalSeparator));
    if (allChars.length > 1) {
      // Cannot input more then one decimal separator
      return oldValue;
    }

    final formatCurrency =
        NumberFormat.currency(symbol: '', name: '', decimalDigits: _calculateDecimalDigits(newValue.text));

    try {
      final value = formatCurrency.parse(newValue.text).toDouble();

      if (newValue.text[newValue.text.length - 1] == _decimalSeparator &&
          oldValue.text[oldValue.text.length - 1] != _decimalSeparator) {
        if (maximumLengthOfWholeNumberPart != null) {
          if (value.toStringAsFixed(0).length >= maximumLengthOfWholeNumberPart!) {
            // Don't allow decimal point if the whole number length is equal to entered number.
            return oldValue;
          }else{
            // New decimal separator inputted, no format required
            return newValue;
          }
        } else {
          // New decimal separator inputted, no format required
          return newValue;
        }
      }

      if (_decimalCountMatcher.hasMatch(newValue.text)) {
        // Only two decimals are allowed
        return oldValue;
      }

      if (maximumLengthOfWholeNumberPart != null) {
        if (value.toStringAsFixed(0).length > maximumLengthOfWholeNumberPart!) {
          return oldValue;
        }
      }
      final formattedText = formatCurrency.format(value);

      // New text
      if (!newValue.text.contains(_decimalSeparator)) {
        return newValue.copyWith(
          text: formattedText.replaceAll('\.+', ''),
          selection: TextSelection.collapsed(
            offset: _calculateOffset(
              newValue.selection.baseOffset,
              oldValue.text,
              formattedText,
            ),
          ),
        );
      } else {
        return newValue.copyWith(
          text: formattedText,
          selection: TextSelection.collapsed(
            offset: _calculateOffset(
              newValue.selection.baseOffset,
              oldValue.text,
              formattedText,
            ),
          ),
        );
      }
    } catch (e) {
      // Couldn't parse this as a decimal number
      return oldValue;
    }
  }

  int _calculateOffset(int baseOffset, String old, String current) {
    if ((old.length - current.length).abs() <= 1 || baseOffset == 0 || baseOffset == 1) {
      return baseOffset;
    }
    if ((old.length - current.length) <= -2) {
      return baseOffset + 1;
    }
    if ((old.length - current.length) >= 2) {
      return baseOffset - 1;
    }
    return current.length;
  }

  int _calculateDecimalDigits(String amount) {
    final dotIndex = amount.indexOf(_decimalSeparator);

    if (dotIndex == -1) {
      return 0;
    } else {
      var substring = amount.substring(amount.lastIndexOf(_decimalSeparator), amount.length);
      return min(2, substring.length - 1);
    }
  }
}
