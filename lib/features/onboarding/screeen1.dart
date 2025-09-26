import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common_widgets/custombutton.dart';

class OnboardingScreen1 extends StatelessWidget {
  const OnboardingScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: Container(
          //  Gradient background
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter, // 360deg = bottom → top
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
                      height: 0.50.sh, // 50% of screen height
                      child: Image.asset(
                        'assets/images/screen1.gif',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  // Bottom section: scrollable text
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 160.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Discover the world, one journey at a time.",
                            style: TextStyle(
                              fontSize: 30.sp,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            "From hidden gems to iconic destinations, we make travel simple, inspiring, and unforgettable. Start your next adventure today.",
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
                      // Page dots (first active)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const _Dot(active: true),
                          SizedBox(width: 8.w),
                          const _Dot(),
                          SizedBox(width: 8.w),
                          const _Dot(),
                        ],
                      ),
                      SizedBox(height: 20.h), // spacing before button
                      // Next button
                      CustomButton(text: "Next", routeName: '/screen2'),
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
