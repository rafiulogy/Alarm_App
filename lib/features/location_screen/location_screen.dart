import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';

import '../../common_widgets/custom_location_screen_button.dart';
import '../../common_widgets/custombutton.dart';

class LocationScreen extends StatelessWidget {
  const LocationScreen({super.key});

  Future<String?> _getCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return 'Location services are disabled.';
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission(); // <-- pop-up here
        if (permission == LocationPermission.denied) {
          return 'Location permission denied';
        }
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      return '${position.latitude}, ${position.longitude}';
    } catch (e) {
      return 'Failed to get location: $e';
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF082257),
                Color(0xFF0B0024),
              ],
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 50.h),
                    Text(
                      "Welcome! Your Smart Travel Alarm",
                      style: TextStyle(
                        fontSize: 32.sp,
                        height: 1.2,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      "Stay on schedule and enjoy every moment of your journey.",
                      style: TextStyle(
                        fontSize: 14.sp,
                        height: 1.45,
                        color: Colors.white70,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 50.h),
                    Center(
                      child: Container(
                        height: 290.h,
                        width: 290.h,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage('assets/images/location_screen_image.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: EdgeInsets.only(bottom: 16.h),
                      child: Column(
                        children: [
                          CustomLocationScreenButton(
                            text: "Use Current Location",
                            iconAsset: 'assets/icons/location_icon.png',
                            onPressed: () async {
                              final location = await _getCurrentLocation();
                              if (location != null) {
                                Get.toNamed('/alarm', arguments: location);
                              }
                            },
                          ),
                          SizedBox(height: 12.h),
                          CustomButton(text: "Home", routeName: '/alarm'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
