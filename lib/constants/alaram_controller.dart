import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:flutter/material.dart';

class AlarmItem {
  final String timeText;
  final String dateText;
  final RxBool enabled;
  final DateTime dateTime;
  bool triggered; // track if alarm already fired

  AlarmItem({
    required this.timeText,
    required this.dateText,
    required bool enabled,
    required this.dateTime,
    this.triggered = false,
  }) : enabled = enabled.obs;
}

class AlarmsController extends GetxController {
  final alarms = <AlarmItem>[].obs;
  Timer? _alarmTimer;

  @override
  void onInit() {
    super.onInit();
    // Periodically check alarms every 30 seconds
    _alarmTimer = Timer.periodic(const Duration(seconds: 30), (_) => _checkAlarms());
  }

  @override
  void onClose() {
    _alarmTimer?.cancel();
    super.onClose();
  }

  // Toggle alarm manually
  void toggle(int index, bool value) {
    alarms[index].enabled.value = value;
    if (!value) {
      alarms[index].triggered = false; // reset triggered if turned off
    }
  }

  // Add a new alarm
  void addAlarm(DateTime dateTime) {
    String timeText = DateFormat("h:mm a").format(dateTime).toLowerCase();
    String dateText = DateFormat("EEE dd MMM yyyy").format(dateTime);

    alarms.insert(
      0,
      AlarmItem(
        timeText: timeText,
        dateText: dateText,
        enabled: true,
        dateTime: dateTime,
      ),
    );
  }

  // Check alarms and trigger if needed
  void _checkAlarms() {
    final now = DateTime.now();

    for (var alarm in alarms) {
      if (alarm.enabled.value && !alarm.triggered && now.isAfter(alarm.dateTime)) {
        alarm.triggered = true;       // mark as triggered
        alarm.enabled.value = false;   // auto-turn off the switch

        // Show snackbar at top
        Get.snackbar(
          'Alarm',
          'Your alarm for ${alarm.timeText} is ringing!',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.deepPurple.withOpacity(0.9),
          colorText: Colors.white,
          margin: const EdgeInsets.all(16),
          duration: const Duration(seconds: 5),
        );

        // TODO: You can add sound or vibration here
      }
    }
  }
}
