import 'package:gold/app/modules/StarLine/models/today_result.dart';

class StarLineGameModel {
  String? sId;
  String? gameName;
  String? openingTime;
  bool? active;
  // String? closingTime;
  bool? hasSpecialTime;
  List<SpecialSchedule>? specialSchedule;
  TodayResultStar? todayResult;
  bool? todayResultDeclared;
  int? iV;

  StarLineGameModel(
      {this.sId,
      this.gameName,
      this.openingTime,
      this.active,
      // this.closingTime,
      this.hasSpecialTime,
      this.specialSchedule,
      this.todayResult,
      this.todayResultDeclared,
      this.iV});

  StarLineGameModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    gameName = json['gameName'];
    openingTime = json['openingTime'];
    active = json['active'];
    todayResultDeclared = json['todayResultDeclared'];
    // closingTime = json['closingTime'];
    hasSpecialTime = json['hasSpecialTime'];
    if (json['specialSchedule'] != null) {
      specialSchedule = <SpecialSchedule>[];
      json['specialSchedule'].forEach((v) {
        specialSchedule!.add(SpecialSchedule.fromJson(v));
      });
    }
    todayResult = json['todayResult'] == null
        ? null
        : TodayResultStar.fromMap(json['todayResult'] as Map<String, dynamic>);
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['gameName'] = gameName;
    data['openingTime'] = openingTime;
    data['active'] = active;
    data['todayResultDeclared'] = todayResultDeclared;
    // data['closingTime'] = closingTime;

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
      SpecialSchedule? todaySchedule = specialSchedule!.firstWhere(
        (schedule) => schedule.dayOfWeek == currentDay,
      );

      // Return the opening time if found, otherwise null
      return todaySchedule.openingTime;
    }

    // If there is no special schedule or the game doesn't have special time, return null
    return openingTime;
  }



  bool isCurrentTimeLessThan() {
    String? targetTime =
        getOpeningTimeToday();
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

class SpecialSchedule {
  String? dayOfWeek;
  bool? isOpen;
  String? openingTime;
  // String? closingTime;
  String? sId;

  SpecialSchedule(
      {this.dayOfWeek,
      this.isOpen,
      this.openingTime,
      // this.closingTime,
      this.sId});

  SpecialSchedule.fromJson(Map<String, dynamic> json) {
    dayOfWeek = json['dayOfWeek'];
    isOpen = json['isOpen'];
    openingTime = json['openingTime'];
    // closingTime = json['closingTime'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dayOfWeek'] = dayOfWeek;
    data['isOpen'] = isOpen;
    data['openingTime'] = openingTime;
    // data['closingTime'] = closingTime;
    data['_id'] = sId;
    return data;
  }
}
