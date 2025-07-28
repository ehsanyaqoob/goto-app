import 'package:flutter/services.dart';

class PassportInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text.toUpperCase(); // Convert to uppercase

    // Restrict to two letters followed by seven digits
    final RegExp passportRegExp = RegExp(r'^[A-Z]{0,2}[0-9]{0,9}$');

    // Only allow input that matches the passport format
    if (!passportRegExp.hasMatch(newText)) {
      return oldValue; // Revert to old value if format is incorrect
    }

    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}