import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:geocoding/geocoding.dart';

import '../../common_widgets/alarm_widget.dart';
import '../../constants/alaram_controller.dart';

class AlarmsScreen extends StatefulWidget {
  const AlarmsScreen({super.key});

  @override
  _AlarmsScreenState createState() => _AlarmsScreenState();
}

class _AlarmsScreenState extends State<AlarmsScreen> {
  String location = 'No location selected';
  DateTime selectedDateTime = DateTime.now();
  late AlarmsController c;

  @override
  void initState() {
    super.initState();
    c = Get.put(AlarmsController()); // inject controller
    _getLocationName();
  }

  // Fetch location name based on coordinates
  void _getLocationName() async {
    final coordinates = [24.1298284, 90.3690799];
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        coordinates[0],
        coordinates[1],
      );
      if (placemarks.isNotEmpty) {
        setState(() {
          location = placemarks.first.name ?? 'No name available';
        });
      }
    } catch (e) {
      print("Error fetching location: $e");
    }
  }

  // Show date & time picker and add alarm
  Future<void> _selectDateTime() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDateTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(selectedDateTime),
      );

      if (pickedTime != null) {
        selectedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        c.addAlarm(selectedDateTime);

        // Show snackbar at top
        Get.snackbar(
          'Alarm Added',
          'Alarm set for ${selectedDateTime.hour}:${selectedDateTime.minute.toString().padLeft(2, '0')}',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.deepPurple.withOpacity(0.9),
          colorText: Colors.white,
          margin: const EdgeInsets.all(16),
          duration: const Duration(seconds: 3),
        );
      }
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
              colors: [ Color(0xFF0B0024),Color(0xFF082257)],
            ),
          ),
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 50.h),
                Padding(
                  padding: EdgeInsets.only(left: 10.w),
                  child: Text(
                    "Selected Location",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(height: 10.h),

                // Location box
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30.r),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        height: 70.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xFF201A43).withOpacity(0.6),
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              color: Colors.white,
                              size: 25.sp,
                            ),
                            SizedBox(width: 15.w),
                            Expanded(
                              child: Text(
                                location,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17.sp,
                                  height: 1.35,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),

                Padding(
                  padding: EdgeInsets.only(left: 10.w),
                  child: Text(
                    "Alarms",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.sp,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                SizedBox(height: 12.h),

                // Alarm list
                Obx(() {
                  return Column(
                    children: List.generate(c.alarms.length, (i) {
                      final a = c.alarms[i];
                      return Padding(
                        padding: EdgeInsets.only(bottom: 12.h),
                        child: AlaramWidget(
                          timeText: a.timeText,
                          dateText: a.dateText,
                          value: a.enabled.value,
                          onChanged: (v) => c.toggle(i, v),
                        ),
                      );
                    }),
                  );
                }),
                SizedBox(height: 12.h),
              ],
            ),
          ),
        ),
        floatingActionButton: SizedBox(
          width: 65,
          height: 65,
          child: FloatingActionButton(
            backgroundColor: const Color(0xFF5200FF),
            onPressed: _selectDateTime,
            shape: const CircleBorder(),
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
