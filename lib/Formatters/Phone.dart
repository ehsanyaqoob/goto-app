import 'package:flutter/services.dart';

class PakistaniPhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text.replaceAll('-', '');

    // Restrict to a maximum of 11 characters (phone number without dashes)
    if (newText.length > 11) {
      newText = newText.substring(0, 11);
    }

    // Format text with dashes
    String formattedText = '';
    for (int i = 0; i < newText.length; i++) {
      if (i == 4) {
        formattedText += '-';
      }
      formattedText += newText[i];
    }

    return newValue.copyWith(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}