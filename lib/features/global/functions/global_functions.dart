import 'dart:math';

import 'package:flutter/material.dart';


class GlobalFunctions {
   int generateRandomId(int min, int max) {
    Random random = Random();
    return min + random.nextInt(max - min);
  }
   String formatTimeOfDay(TimeOfDay time, {
     bool twentyFourHourFormat = false,
     String separator = ':',
   }) {
     String hourStr;
     String minuteStr = time.minute.toString().padLeft(2, '0');

     if (twentyFourHourFormat) {
       hourStr = time.hour.toString().padLeft(2, '0');
     } else {
       int hour = time.hour;
       hour = hour % 12;
       hour = hour == 0 ? 12 : hour; // Convert 0 to 12 for 12-hour format
       hourStr = hour.toString().padLeft(2, '0');
     }

     return '$hourStr$separator$minuteStr';
   }
   TimeOfDay stringToTimeOfDay(String timeStr) {
     // Split the string by colon
     final parts = timeStr.split(':');

     // Must have exactly 2 parts (hours and minutes)
     if (parts.length != 2) {
       throw FormatException('Invalid time format, use HH:MM');
     }

     // Parse to integers
     final hour = int.tryParse(parts[0]);
     final minute = int.tryParse(parts[1]);

     // Check if parsing succeeded and values are valid
     if (hour == null || minute == null) {
       throw FormatException('Time must contain numbers only');
     }
     if (hour < 0 || hour > 23) {
       throw FormatException('Hour must be between 0-23');
     }
     if (minute < 0 || minute > 59) {
       throw FormatException('Minute must be between 0-59');
     }

     return TimeOfDay(hour: hour, minute: minute);
   }
}
