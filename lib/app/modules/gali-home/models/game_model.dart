// ignore_for_file: public_member_api_docs, sort_constructors_first



import 'package:gold/app/modules/gali-home/models/today_result.dart';

class GaliGameModel {
  String? sId;
  String? gameName;
  String? time;
  bool? active;

  bool? hasSpecialTime;
  List<GaliSpecialSchedule>? specialSchedule;
  GaliTodayResult? todayResult;
  bool todayResultDeclared = false;
  int? iV;

  GaliGameModel(
      {this.sId,
      this.gameName,
      this.active,
      this.time,
      this.hasSpecialTime,
      this.specialSchedule,
      this.todayResult,
      this.todayResultDeclared=false,
      this.iV});

  GaliGameModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    gameName = json['gameName'];
    time = json['time'];
       active = json['active'] as bool?;
   todayResultDeclared = json['todayResultDeclared'] as bool;

    hasSpecialTime = json['hasSpecialTime'];
    if (json['specialSchedule'] != null) {
      specialSchedule = <GaliSpecialSchedule>[];
      json['specialSchedule'].forEach((v) {
        specialSchedule!.add(GaliSpecialSchedule.fromJson(v));
      });
    }
    todayResult = json['todayResult'] == null
        ? null
        : GaliTodayResult.fromMap(json['todayResult'] as Map<String, dynamic>);
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['gameName'] = gameName;
    data['time'] = time;
    data['active'] = active;
    data['todayResultDeclared'] = todayResultDeclared;

    data['hasSpecialTime'] = hasSpecialTime;
    if (specialSchedule != null) {
      data['specialSchedule'] =
          specialSchedule!.map((v) => v.toJson()).toList();
    }
    data['__v'] = iV;
    data['todayResult'] = todayResult?.toMap();
    return data;
  }

  bool isGameOpenToday() {
    if (hasSpecialTime == true && specialSchedule != null) {
      int currentDay = DateTime.now().toLocal().weekday;

      // Check if there is a special schedule for the current day
      // log(currentDay);
      return specialSchedule!.any((schedule) =>
          schedule.dayOfWeek == getDayName(currentDay) &&
          schedule.isOpen == true);
    }

    // If there is no special schedule or the game doesn't have special time, consider it open
    return true;
  }

  String? getOpeningTimeToday() {
    if (hasSpecialTime == true && specialSchedule != null) {
      String currentDay = getDayName(DateTime.now().toLocal().weekday);

      // Find the special schedule for the current day
      GaliSpecialSchedule? todaySchedule = specialSchedule!.firstWhere(
        (schedule) => schedule.dayOfWeek == currentDay,
      );

      // Return the opening time if found, otherwise null
      return todaySchedule.time;
    }

    // If there is no special schedule or the game doesn't have special time, return null
    return time;
  }

  bool isCurrentTimeLessThan() {
    String? targetTime = getOpeningTimeToday();
    // String? targetTime = getClosingTimeToday();
    if (targetTime == null) {
      return false;
    }
    targetTime = convert12HourTo24Hour(targetTime.toString());
    DateTime currentTime = DateTime.now();
    DateTime targetDateTime = DateTime(
      currentTime.year,
      currentTime.month,
      currentTime.day,
      int.parse(targetTime.split(':')[0]),
      int.parse(targetTime.split(':')[1].split(' ')[0]),
    );

    return currentTime.isBefore(targetDateTime);
  }

  @override
  String toString() {
    return 'GaliGameModel(sId: $sId, gameName: $gameName, openingTime: $time, active: $active, hasSpecialTime: $hasSpecialTime, specialSchedule: $specialSchedule, todayResult: $todayResult, todayResultDeclared: $todayResultDeclared, iV: $iV)';
  }
}

String convert12HourTo24Hour(String time12Hour) {
  // Split the time into hours, minutes, and AM/PM
  List<String> parts = time12Hour.split(' ');
  String time = parts[0];
  String period = parts[1];

  // Split hours and minutes
  List<String> timeParts = time.split(':');
  int hours = int.parse(timeParts[0]);
  int minutes = int.parse(timeParts[1]);

  // Convert to 24-hour format
  if (period == 'PM' && hours < 12) {
    hours += 12;
  } else if (period == 'AM' && hours == 12) {
    hours = 0;
  }

  // Format the result
  String hoursStr = hours.toString().padLeft(2, '0');
  String minutesStr = minutes.toString().padLeft(2, '0');

  return '$hoursStr:$minutesStr';
}

String getDayName(int day) {
  // List of day names
  List<String> dayNames = [
    'MONDAY',
    'TUESDAY',
    'WEDNESDAY',
    'THURSDAY',
    'FRIDAY',
    'SATURDAY',
    'SUNDAY'
  ];

  // Get the day index (0-6) from the DateTime object
  int dayIndex =
      day - 1; // Dart uses 1 for Monday, 2 for Tuesday, ..., 7 for Sunday

  // Return the corresponding day name
  return dayNames[dayIndex];
}

class GaliSpecialSchedule {
  String? dayOfWeek;
  bool? isOpen;

  String? time;
  String? sId;

  GaliSpecialSchedule({this.dayOfWeek, this.isOpen, this.time, this.sId});

  GaliSpecialSchedule.fromJson(Map<String, dynamic> json) {
    dayOfWeek = json['dayOfWeek'];
    isOpen = json['isOpen'];
    time = json['time'];

    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dayOfWeek'] = dayOfWeek;
    data['isOpen'] = isOpen;
    data['time'] = time;

    data['_id'] = sId;
    return data;
  }
}
