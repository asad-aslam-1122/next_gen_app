import 'dart:convert';
import 'dart:developer';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:daylight/daylight.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import '../../home/data/model/timezone_model.dart';

class TimezoneUtils {
  static List<TimezoneModel> allTimezones=[];
  static DateTime? sunset;
  static DateTime? sunrise;

  static Future<void> getAllTimezones() async {
    final data = await rootBundle.loadString('assets/json/timezone_centroids.json');

    final raw = await jsonDecode(data) as Map<String, dynamic>;

    Map<dynamic, dynamic> timezoneCentroids = raw['timezones'].map((key, value) {
      final lat = value['lat'];
      final lng = value['lng'];
      return MapEntry(key, {'lat': lat, 'lng': lng});
    });
    allTimezones= timezoneCentroids.entries.map((entry) {
      final timezone = entry.key.toString();
      final centroid = entry.value;

      return TimezoneModel(
        timezone: timezone,
        lat: centroid['lat']?.toDouble(),
        lng: centroid['lng']?.toDouble(),
      );
    }).toList();
  }

  static Future<TimezoneModel?> getLatLngForTimezone(String timezone) async {
    return allTimezones.firstWhereOrNull((e)=>e.timezone==timezone);
  }

  static void getLocalSunTimes(String timezoneName,double lat,double lng) async {
    // Initialize timezone database
    tz.initializeTimeZones();

    final location = tz.getLocation(timezoneName);

    // Get sun times (UTC)
    final berlin = DaylightLocation(lat, lng);
    final berlinCalculator = DaylightCalculator(berlin);
    final dailyResults = berlinCalculator.calculateForDay(DateTime.now());

    // Convert to local timezone
    final localSunrise = tz.TZDateTime.from(dailyResults.sunrise!, location);
    final localSunset = tz.TZDateTime.from(dailyResults.sunset!, location);
    sunrise=convertTZDateTimeToDateTime(localSunrise);
    sunset=convertTZDateTimeToDateTime(localSunset);
    print('Local sunrise: ${localSunrise}____${sunrise}');
    print('Local sunset: ${localSunset}____${sunset}');
  }
  static DateTime convertTZDateTimeToDateTime(tz.TZDateTime tzDateTime) {
    return DateTime(
      tzDateTime.year,
      tzDateTime.month,
      tzDateTime.day,
      tzDateTime.hour,
      tzDateTime.minute,
      tzDateTime.second,
      tzDateTime.millisecond,
      tzDateTime.microsecond,
    );
  }

  static setDefaultTimezoneSunTimes()async
  {
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    TimezoneModel? timezoneLatLng=await  getLatLngForTimezone(currentTimeZone);
    TimezoneUtils.getLocalSunTimes(timezoneLatLng?.timezone??"Asia/Karachi",timezoneLatLng?.lat??24.8607,timezoneLatLng?.lng??67.0011);
  }
}


