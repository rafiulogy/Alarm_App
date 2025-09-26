import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// AlaramWidget (transparent version with #201A43)
class AlaramWidget extends StatelessWidget {
  final String timeText;       // e.g., "7:10 pm"
  final String dateText;       // e.g., "Fri 21 Mar 2025"
  final bool value;            // switch value
  final ValueChanged<bool> onChanged;

  const AlaramWidget({
    super.key,
    required this.timeText,
    required this.dateText,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    const purple = Color(0xFF7B4CDF); // brand purple

    return Padding(
      padding: EdgeInsets.only(left: 10.h, right: 10.r),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF201A43).withOpacity(0.6), // semi-transparent #201A43
          borderRadius: BorderRadius.circular(30.r),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        child: Row(
          children: [
            // Big time on the left
            Text(
              timeText,
              style: TextStyle(
                color: Colors.white,
                fontSize: 26.sp,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.1,
              ),
            ),
            const Spacer(),
            // Date on the right (semi-bold small)
            Text(
              dateText,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(width: 12.w),
            // Compact switch
            Transform.scale(
              scale: 0.90,
              child: Switch(
                value: value,
                onChanged: onChanged,
                activeTrackColor: purple,
                activeThumbColor: Colors.white,
                inactiveThumbColor: Colors.white,
                inactiveTrackColor: Colors.grey.shade600,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
