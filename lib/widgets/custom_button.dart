import 'package:flutter/material.dart';
import 'package:goto/constants/exports.dart';
import 'package:sizer/sizer.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.title,
    this.onTap,
    this.isDisabled = false,
    this.topMargin = 0.0,
    this.fillColor = true,
    this.filledColor,
    this.borderColor,
    this.shadow = false,
    this.isLoading = false,
    this.height,
    this.width,
    this.borderRadius,
    this.textStyle,
    this.hoverColor,
    this.elevation = 0.0,
    this.loaderColor,
  });

  final String title;
  final VoidCallback? onTap;
  final bool isDisabled;
  final double topMargin;
  final bool fillColor;
  final Color? filledColor;
  final Color? borderColor;
  final bool shadow;
  final bool isLoading;
  final double? height;
  final double? width;
  final double? borderRadius;
  final TextStyle? textStyle;
  final Color? hoverColor;
  final double elevation;
  final Color? loaderColor;

  @override
  Widget build(BuildContext context) {
    final defaultRadius = borderRadius ?? 12.0;
    final defaultHeight = height ?? 7.h;
    final defaultWidth = width ?? double.infinity;
    final defaultFilledColor = filledColor ?? AppColors.primary;
    final defaultLoaderColor = loaderColor ?? AppColors.appWhite;

    return Padding(
      padding: EdgeInsets.only(top: topMargin),
      child: Material(
        borderRadius: BorderRadius.circular(defaultRadius),
        elevation: elevation,
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(defaultRadius),
          splashColor: hoverColor ?? defaultFilledColor.withOpacity(0.2),
          onTap: isDisabled || isLoading ? null : onTap,
          child: Container(
            height: defaultHeight,
            width: defaultWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(defaultRadius),
              border: Border.all(
                color: borderColor ?? defaultFilledColor,
                width: 1.0,
              ),
              gradient: fillColor
                  ? LinearGradient(
                      colors: [
                        defaultFilledColor.withOpacity(isDisabled ? 0.5 : 0.9),
                        defaultFilledColor.withOpacity(isDisabled ? 0.5 : 0.9),
                      ],
                    )
                  : null,
              color: fillColor ? null : Colors.transparent,
              boxShadow: shadow
                  ? [
                      BoxShadow(
                        color:
                            borderColor?.withOpacity(0.5) ??
                            defaultFilledColor.withOpacity(0.3),
                        spreadRadius: 1,
                        blurRadius: 6,
                        offset: const Offset(2, 2),
                      ),
                    ]
                  : [],
            ),
            child: Center(
              child: isLoading
                  ? SizedBox(
                      width: 20.sp,
                      height: 20.sp,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          defaultLoaderColor,
                        ),
                      ),
                    )
                  : Text(
                      title,
                      style:
                          textStyle ??
                          TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: fillColor
                                ? (isDisabled
                                      ? AppColors.lightGrey
                                      : AppColors.appWhite)
                                : defaultFilledColor,
                          ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
