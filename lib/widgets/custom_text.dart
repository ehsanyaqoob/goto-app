import 'package:flutter/services.dart';
import 'package:goto/Constants/exports.dart';
import 'package:goto/constants/Theme/app_fonts.dart';
import 'package:sizer/sizer.dart';

class CustomText extends Text {
  CustomText({
    super.key,
    required String text,
    TextAlign textAlign = TextAlign.left,
    Color color = Colors.black,
    double fontSize = 9,
    FontWeight fontWeight = FontWeight.normal,
    double? letterSpacing,
    TextDecoration? textDecoration,
    TextDecorationStyle? textDecorationStyle,
    Color? decorationColor,
    String font = 'Roboto',
    int? maxLines,
    TextOverflow? overflow,
  }) : super(
         text,
         textAlign: textAlign,
         overflow: overflow ?? TextOverflow.ellipsis,
         maxLines: maxLines ?? 2,
         style: TextStyle(
           color: color,
           fontFamily: font,
           fontSize: fontSize,
           fontWeight: fontWeight,
           letterSpacing: letterSpacing,
           decoration: textDecoration,
           decorationStyle: textDecorationStyle,
           decorationColor: decorationColor,
         ),
       );
}

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String hint;
  final String title;
  final TextInputType? inputType;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? prefix;
  final ValueChanged<String>? onChanged;
  final bool? isObscure;
  final VoidCallback? onTap;
  final String? errorText;
  final bool? readOnly;
  final bool? autoFocus;
  final Widget? suffix;
  final double? topPadding;
  final TextAlign textAlign;
  final TextCapitalization textCapitalization;
  final TextInputAction textInputAction;
  final ValueChanged<String>? onSubmitted;
  final String? Function(String?)? validator;
  final String? initialValue;
  final bool? enabled;
  CustomTextFormField({
    Key? key,
    this.controller,
    required this.hint,
    this.title = '',
    this.inputType = TextInputType.text,
    this.inputFormatters,
    this.prefix,
    this.onChanged,
    this.isObscure,
    this.onTap,
    this.errorText,
    this.readOnly,
    this.autoFocus,
    this.suffix,
    this.topPadding,
    this.textAlign = TextAlign.left,
    this.textCapitalization = TextCapitalization.sentences,
    this.textInputAction = TextInputAction.next,
    this.onSubmitted,
    this.validator,
    this.initialValue,
    this.enabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: topPadding ?? 0.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: title.isNotEmpty,
            child: CustomText(
              text: title,
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.appWhite,
            ),
          ),
          SizedBox(height: title.isNotEmpty ? 5 : 5),
          TextFormField(
            textInputAction: textInputAction,
            textCapitalization: textCapitalization,
            controller: controller,
            keyboardType: inputType,
            inputFormatters: inputFormatters,
            cursorColor: AppColors.appPrimary,
            autofocus: autoFocus ?? false,
            textAlign: textAlign,
            onTapOutside: (event) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            onFieldSubmitted: onSubmitted,
            decoration: InputDecoration(
              hintText: hint,
              prefixIcon: prefix,
              suffixIcon: suffix,
              fillColor: Colors.grey[100], // iOS-style soft background
              filled: true,
              errorText: errorText,
              hintStyle: TextStyle(
                color: Colors.grey[500],
                fontSize: 16,
                fontFamily: AppFonts.roboto,
                fontWeight: FontWeight.w400,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30), // More rounded corners
                borderSide: BorderSide(
                  color: Colors.grey[300]!,
                ), // light grey like iOS
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(
                  color: AppColors.primary,
                  width: 1.5,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: Colors.red),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: Colors.red),
              ),

              isDense: true, // Compact layout
            ),

            readOnly: readOnly ?? false,
            style: TextStyle(
              color: AppColors.appBlack,
              fontSize: 14.sp,
              fontFamily: AppFonts.roboto,
              fontWeight: FontWeight.w500,
            ),
            onChanged: onChanged,
            onTap: onTap,
            obscureText: isObscure ?? false,
            validator: validator,
            enabled: enabled ?? true,
          ),
        ],
      ),
    );
  }
}

class CustomTextField extends TextFormField {
  CustomTextField({
    super.key,
    TextEditingController? controller,
    required String hint,
    TextInputType? inputType,
    List<TextInputFormatter>? inputFormatters,
    Widget? prefix,
    super.onChanged,
    bool? isObscure,
    super.onTap,
    String? errorText,
    bool? readOnly,
    bool? autoFocus,
    Widget? suffix,
  }) : assert(controller != null, "Controller is required"),
       super(
         controller: controller!,
         keyboardType: inputType,
         inputFormatters: inputFormatters,
         cursorColor: AppColors.appBlack,
         autofocus: autoFocus ?? false,
         decoration: InputDecoration(
           hintText: hint,
           prefixIcon: prefix,
           suffixIcon: suffix,
           fillColor: Colors.grey[100], // iOS-style soft background
           filled: true,
           errorText: errorText,
           hintStyle: TextStyle(
             color: Colors.grey[500],
             fontSize: 16,
             fontFamily: AppFonts.roboto,
             fontWeight: FontWeight.w400,
           ),
           contentPadding: const EdgeInsets.symmetric(
             horizontal: 16,
             vertical: 12,
           ),

           border: OutlineInputBorder(
             borderRadius: BorderRadius.circular(30), // More rounded corners
             borderSide: BorderSide(
               color: Colors.grey[300]!,
             ), // light grey like iOS
           ),
           enabledBorder: OutlineInputBorder(
             borderRadius: BorderRadius.circular(30),
             borderSide: BorderSide(color: Colors.grey[300]!),
           ),
           focusedBorder: OutlineInputBorder(
             borderRadius: BorderRadius.circular(30),
             borderSide: BorderSide(color: AppColors.primary, width: 1.5),
           ),
           errorBorder: OutlineInputBorder(
             borderRadius: BorderRadius.circular(30),
             borderSide: const BorderSide(color: Colors.red),
           ),
           focusedErrorBorder: OutlineInputBorder(
             borderRadius: BorderRadius.circular(30),
             borderSide: const BorderSide(color: Colors.red),
           ),

           isDense: true, // Compact layout
         ),
         readOnly: readOnly ?? false,
         style: TextStyle(
           color: AppColors.appBlack,
           fontSize: 18,
           fontFamily: AppFonts.roboto,
           fontWeight: FontWeight.w600,
         ),
         obscureText: isObscure ?? false,
       );
}
