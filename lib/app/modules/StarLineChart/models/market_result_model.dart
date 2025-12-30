import 'dart:convert';


import 'package:intl/intl.dart';
class StarLineMarketResultModel {
  final String? id;
  final String? gameName;
  final String? openPana;

  final DateTime? timestamp;
  final int? v;

  const StarLineMarketResultModel({
    this.id,
    this.gameName,
    this.openPana,

    this.timestamp,
    this.v,
  });

  factory StarLineMarketResultModel.fromMap(Map<String, dynamic> data) {
    return StarLineMarketResultModel(
      id: data['_id'] as String?,
      gameName: data['gameName'] as String?,
      openPana: data['openPana'] as String?,

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

        'timestamp': timestamp?.toIso8601String(),
        '__v': v,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [MarketResultModel].
  factory StarLineMarketResultModel.fromJson(String data) {
    return StarLineMarketResultModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [MarketResultModel] to a JSON string.
  String toJson() => json.encode(toMap());

  StarLineMarketResultModel copyWith({
    String? id,
    String? gameName,
    String? openPana,

    DateTime? timestamp,
    int? v,
  }) {
    return StarLineMarketResultModel(
      id: id ?? this.id,
      gameName: gameName ?? this.gameName,
      openPana: openPana ?? this.openPana,

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

      timestamp,
      v,
    ];
  }

  // String calculateAnk() {
  //   String? openPanaAnk = calculateSingleAnk(openPana);
  //   String? closePanaAnk = calculateSingleAnk(closePana);

  //   // Concatenate the ank for openPana and closePana
  //   return '$openPanaAnk$closePanaAnk';
  // }

  String? calculateSingleAnk() {
    if (openPana == null || openPana!.isEmpty) {
      return "*";
    }

    // Convert the pana to a string to iterate through each digit
    String digitString = openPana.toString();

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
