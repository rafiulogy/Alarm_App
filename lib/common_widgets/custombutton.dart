import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;   // optional callback
  final String? routeName;         // optional GetX route
  final bool replace;              // use Get.offAllNamed if true
  final Color color;               // customizable button color

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.routeName,
    this.replace = false,
    this.color = const Color(0xFF5200FF),
  });

  @override
  Widget build(BuildContext context) {
    final bool isEnabled = (onPressed != null || routeName != null);

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isEnabled
            ? () {
          if (routeName != null) {
            replace
                ? Get.offAllNamed(routeName!) // replace navigation
                : Get.toNamed(routeName!);    // push navigation
          } else {
            onPressed?.call();
          }
        }
            : null, // disable button if no action
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          disabledBackgroundColor: Colors.grey.shade600,
          padding: EdgeInsets.symmetric(vertical: 16.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.r),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
