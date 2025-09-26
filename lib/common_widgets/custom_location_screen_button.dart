import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomLocationScreenButton extends StatelessWidget {
  final String text;
  final String? routeName;          // optional GetX route
  final VoidCallback? onPressed;    // optional callback
  final bool replace;               // use Get.offAllNamed when true
  final String? iconAsset;          // optional trailing icon png
  final Color borderColor;
  final Color textColor;

  const CustomLocationScreenButton({
    super.key,
    required this.text,
    this.routeName,
    this.onPressed,
    this.replace = false,
    this.iconAsset,
    this.borderColor = Colors.grey,   // default grey border
    this.textColor = Colors.white,     // default grey text
  });

  @override
  Widget build(BuildContext context) {
    final bool enabled = routeName != null || onPressed != null;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: enabled
            ? () {
          if (routeName != null) {
            replace ? Get.offAllNamed(routeName!) : Get.toNamed(routeName!);
          } else {
            onPressed?.call();
          }
        }
            : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent, // transparent background
          disabledBackgroundColor: Colors.transparent.withOpacity(0.2),
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.r),
            side: BorderSide(color: borderColor, width: 1.5), // grey border
          ),
          elevation: 0, // remove shadow
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Text(
                text,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: textColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            if (iconAsset != null) ...[
              SizedBox(width: 10.w),
              Image.asset(
                iconAsset!,
                height: 18.h,
                width: 18.h,
                errorBuilder: (_, __, ___) => Icon(
                  Icons.my_location_outlined,
                  size: 18.h,
                  color: textColor,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
