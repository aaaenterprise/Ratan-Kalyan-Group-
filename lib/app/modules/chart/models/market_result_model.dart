import 'dart:convert';


import 'package:intl/intl.dart';
class MarketResultModel  {
  final String? id;
  final String? gameName;
  final String? openPana;
  final String? closePana;
  final DateTime? timestamp;
  final int? v;

  const MarketResultModel({
    this.id,
    this.gameName,
    this.openPana,
    this.closePana,
    this.timestamp,
    this.v,
  });

  factory MarketResultModel.fromMap(Map<String, dynamic> data) {
    return MarketResultModel(
      id: data['_id'] as String?,
      gameName: data['gameName'] as String?,
      openPana: data['openPana'] as String?,
      closePana: data['closePana'] as String?,
      timestamp: data['timestamp'] == null
          ? null
          : DateTime.parse(data['timestamp'] as String),
      v: data['__v'] as int?,
    );
  }

  Map<String, dynamic> toMap() => {
        '_id': id,
        'gameName': gameName,
        'openPana': openPana,
        'closePana': closePana,
        'timestamp': timestamp?.toIso8601String(),
        '__v': v,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [MarketResultModel].
  factory MarketResultModel.fromJson(String data) {
    return MarketResultModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [MarketResultModel] to a JSON string.
  String toJson() => json.encode(toMap());

  MarketResultModel copyWith({
    String? id,
    String? gameName,
    String? openPana,
    String? closePana,
    DateTime? timestamp,
    int? v,
  }) {
    return MarketResultModel(
      id: id ?? this.id,
      gameName: gameName ?? this.gameName,
      openPana: openPana ?? this.openPana,
      closePana: closePana ?? this.closePana,
      timestamp: timestamp ?? this.timestamp,
      v: v ?? this.v,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      gameName,
      openPana,
      closePana,
      timestamp,
      v,
    ];
  }

  String calculateAnk() {
    String? openPanaAnk = calculateSingleAnk(openPana);
    String? closePanaAnk = calculateSingleAnk(closePana);

    // Concatenate the ank for openPana and closePana
    return '$openPanaAnk$closePanaAnk';
  }

  String? calculateSingleAnk(String? pana) {
    if (pana == null || pana.isEmpty) {
      return "*";
    }

    // Convert the pana to a string to iterate through each digit
    String digitString = pana.toString();

    // Sum all the digits
    int digitSum =
        digitString.split('').fold(0, (sum, digit) => sum + int.parse(digit));

    // Get the last digit of the summation
    int lastDigit = digitSum % 10;

    return lastDigit.toString();
  }

   DateInfo formatDate() {
    // Parse the date string
    DateTime dateTime = DateTime.parse(timestamp.toString());

    // Get the day name (e.g., Monday, Tuesday, etc.)
    String dayName = DateFormat('EE').format(dateTime);

    // Get the month name (e.g., January, February, etc.)
    String monthName = DateFormat('MMM').format(dateTime);

    // Get the day of the month (e.g., 1, 2, 3, etc.)
    int dayOfMonth = dateTime.day;

    // Construct the formatted string
    // String formattedDate = '$dayName, $monthName $dayOfMonth';

    return DateInfo(
      dayName: dayName,
      monthName: monthName,
      dayOfMonth: dayOfMonth,
    );
  }
}

class DateInfo {
  final String dayName;
  final String monthName;
  final int dayOfMonth;

  DateInfo({
    required this.dayName,
    required this.monthName,
    required this.dayOfMonth,
  });
}
