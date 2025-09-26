import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common_widgets/custombutton.dart';

class OnboardingScreen3 extends StatelessWidget {
  const OnboardingScreen3({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: Container(
          // 🌈 Gradient background
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter, // 360° bottom → top
              end: Alignment.topCenter,
              colors: [
                Color(0xFF082257), // dark blue
                Color(0xFF0B0024), // deep purple/black
              ],
            ),
          ),
          child: Stack(
            children: [
              // --- MAIN CONTENT ---
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Top image with rounded bottom corners
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(28.r),
                      bottomRight: Radius.circular(28.r),
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      height: 0.50.sh,
                      child: Image.asset(
                        'assets/images/screen3.gif',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  // Bottom section (scrollable text only)
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      padding: EdgeInsets.fromLTRB(20.w, 22.h, 20.w, 160.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "See the beauty, one journey at a time.",
                            style: TextStyle(
                              fontSize: 30.sp,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 12.h),
                          Text(
                            "Travel made simple and exciting—discover places you’ll love and moments you’ll never forget.",
                            style: TextStyle(
                              fontSize: 14.sp,
                              height: 1.45,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              // --- SKIP BUTTON ---
              Positioned(
                top: MediaQuery.of(context).padding.top + 12.h,
                right: 16.w,
                child: TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 6.h,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                  ),
                  onPressed: () => Get.offAllNamed('/location'),
                  child: Text("Skip", style: TextStyle(fontSize: 14.sp)),
                ),
              ),

              // --- FIXED DOTS + BUTTON ---
              Positioned(
                left: 20.w,
                right: 20.w,
                bottom: 16.h,
                child: SafeArea(
                  minimum: EdgeInsets.only(bottom: 8.h),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Page dots (third active)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const _Dot(),
                          SizedBox(width: 8.w),
                          const _Dot(),
                          SizedBox(width: 8.w),
                          const _Dot(active: true),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      // Get Started button
                      CustomButton(
                        text: "Next",
                        routeName: '/location',
                        replace: true, // clear onboarding history
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  final bool active;
  const _Dot({this.active = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8.r,
      width: 8.r,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: active ? const Color(0xFF7B4CDF) : Colors.grey.shade600,
      ),
    );
  }
}
