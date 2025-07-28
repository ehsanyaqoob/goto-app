import 'package:flutter/services.dart';

class CNICInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text.replaceAll('-', '');

    // Restrict to a maximum of 13 characters (CNIC without dashes)
    if (newText.length > 13) {
      newText = newText.substring(0, 13);
    }

    // Format text with dashes
    String formattedText = '';
    for (int i = 0; i < newText.length; i++) {
      if (i == 5 || i == 12) {
        formattedText += '-';
      }
      formattedText += newText[i];
    }

    return newValue.copyWith(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }

  // bool _hasContinuousSequenceOrRepeatingDigits(String input) {
  //   // Check repeating digits in the first three positions
  //   for (int i = 0; i < 3 && i < input.length - 2; i++) {
  //     int current = int.tryParse(input[i]) ?? -1;
  //     int next = int.tryParse(input[i + 1]) ?? -1;
  //     int nextNext = int.tryParse(input[i + 2]) ?? -1;
  //
  //     if (current != -1 && next != -1 && nextNext != -1) {
  //       // Check for increasing or decreasing sequence
  //       if ((current + 1 == next && next + 1 == nextNext) ||
  //           (current - 1 == next && next - 1 == nextNext)) {
  //         return true;
  //       }
  //       // Check for repeated digits in the first three positions
  //       if (i == 0 && current == next && next == nextNext) {
  //         return true;
  //       }
  //     }
  //   }
  //   return false;
  // }
}