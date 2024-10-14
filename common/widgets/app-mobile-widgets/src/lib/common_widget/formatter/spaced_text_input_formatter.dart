import 'package:flutter/services.dart';

class SpacedTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    _,
    TextEditingValue newValue, {
    SpaceTextInputFormattingMode mode =
        SpaceTextInputFormattingMode.fourDigitsSeparation,
  }) {
    // Find the position in the string with spaces removed
    int oldOffset = newValue.selection.baseOffset -
        RegExp(' ')
            .allMatches(newValue.text)
            .map((e) => e.start < newValue.selection.baseOffset)
            .fold(0, (x, y) => x + (y ? 1 : 0));
    var splitText = _splitInGroups(newValue.text, mode);
    // Find the new position by considering spaces inserted on the left
    int newOffset = oldOffset;
    for (var i = 0; i < newOffset; i += 1) {
      if (splitText[i] == ' ') {
        newOffset += 1;
      }
    }

    return TextEditingValue(
      text: splitText,
      selection: TextSelection.collapsed(
        offset: newOffset,
      ),
    );
  }

  String _splitInGroups(String input, SpaceTextInputFormattingMode mode) {
    input = input.replaceAll(RegExp(' '), '');
    var segments = input.split('');
    var groupSize = 4;
    var added = 0;
    var it = segments.iterator;
    final buffer = StringBuffer();
    var remainderOfDivision =
        mode == SpaceTextInputFormattingMode.ibanWithoutFirstLetters ? 2 : 0;
    while (it.moveNext()) {
      if (added != 0 && added % groupSize == remainderOfDivision) {
        buffer.write(' ');
      }
      added++;
      buffer.write(it.current);
    }
    return buffer.toString();
  }
}

/// Defines type of formatting.
enum SpaceTextInputFormattingMode {
  fourDigitsSeparation,

  /// Expects to have two first digits separately
  ibanWithoutFirstLetters
}
