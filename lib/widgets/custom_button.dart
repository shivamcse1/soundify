import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soundify/core/theme/app_colors.dart';
import 'package:soundify/widgets/custom_text.dart';

class CustomElevatedButton extends StatelessWidget {
  final Widget? preWidget;
  final String buttonText;
  final void Function()? onTap;
  final double? height;
  final double? width;
  final double? borderWidth;
  final double? radius;
  final Color? buttonColor;
  final Color? borderColor;
  final Color? loderColor;
  final TextStyle? buttonTextStyle;
  final bool? isTextFieldEmpty;
  final bool isLoading;
  final EdgeInsetsGeometry? margin;

  const CustomElevatedButton({
    super.key,
    required this.buttonText,
    required this.onTap,
    this.height = 40,
    this.width,
    this.radius,
    this.buttonColor,
    this.loderColor = Colors.white,
    this.buttonTextStyle,
    this.isTextFieldEmpty = true,
    this.margin,
    this.isLoading = false,
    this.borderWidth,
    this.borderColor,
    this.preWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      height: height!.h,
      width: width?.w,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor:
              isTextFieldEmpty == true
                  ? buttonColor ?? AppColors.error
                  : AppColors.error,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: borderWidth ?? 1,
              color: buttonColor ?? borderColor ?? AppColors.error,
            ),
            borderRadius: BorderRadius.circular(
              radius?.r ?? 10.r,
            ),
          ),
        ),
        onPressed: onTap,
        child:
            (isLoading == true)
                ? Visibility(
                  visible: isLoading,
                  child: Container(
                    width: height!.h / 1.5,
                    height: height!.h / 1.18,
                    padding: EdgeInsets.symmetric(vertical: 5.h),
                    child: CircularProgressIndicator(
                      color: loderColor,
                      // backgroundColor: Colors.whi,
                    ),
                  ),
                )
                : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (preWidget != null) ...[
                      preWidget!,
                      SizedBox(width: 5.w),
                    ] else ...[
                      SizedBox(),
                    ],
                    Flexible(
                      child: CustomText(
                        text: buttonText,
                        style: buttonTextStyle 
                      ),
                    ),
                  ],
                ),
      ),
    );
  }
}



class CustomTextButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onTap;
  final double? height;
  final double? width;
  final double? buttonElevation;
  final Size? minimumSize;
  final double? borderWidth;
  final double? radius;
  final Color? buttonColor;
  final Color? borderColor;
  final Color? loderColor;
  final Color? foregroundColor;
  final MaterialTapTargetSize? tapTargetSize;
  final TextStyle? buttonTextStyle;
  final bool isLoading;
  final OutlinedBorder? buttonShape;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  const CustomTextButton({
    super.key,
    required this.buttonText,
    required this.onTap,
    this.height,
    this.width,
    this.radius,
    this.buttonColor = Colors.transparent,
    this.loderColor = AppColors.white,
    this.buttonTextStyle,
    this.margin,
    this.isLoading = false,
    this.borderWidth,
    this.borderColor,
    this.buttonShape,
    this.padding,
    this.minimumSize,
    this.tapTargetSize,
    this.buttonElevation,
    this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      height: height?.h,
      width: width?.w,
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: foregroundColor,
          splashFactory: InkRipple.splashFactory,
          padding: padding,
          elevation: buttonElevation,
          minimumSize: minimumSize,
          backgroundColor: buttonColor,
          tapTargetSize: tapTargetSize,
          shape: buttonShape,
        ),
        onPressed: onTap,
        child:
            (isLoading == true)
                ? Visibility(
                  visible: isLoading,
                  child: Container(
                    width: height!.h / 1.5,
                    height: height!.h / 1.18,
                    padding: EdgeInsets.symmetric(vertical: 5.h),
                    child: CircularProgressIndicator(
                      color: loderColor,
                      // backgroundColor: Colors.whi,
                    ),
                  ),
                )
                : CustomText(text: buttonText, style: buttonTextStyle),
      ),
    );
  }
}
