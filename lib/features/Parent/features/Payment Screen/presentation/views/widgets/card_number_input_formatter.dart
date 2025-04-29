import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final newText = StringBuffer();
    int digitCount = 0;

    for (int i = 0; i < newValue.text.length; i++) {
      if (digitCount == 4 || digitCount == 8 || digitCount == 12) {
        newText.write(' ');
      }
      newText.write(newValue.text[i]);
      digitCount++;
    }

    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
