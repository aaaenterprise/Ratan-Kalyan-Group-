import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class GaliMarketResultModel extends Equatable {
  final String? id;
  final String? gameName;
  final String? digit;

  final DateTime? timestamp;
  final int? v;

  const GaliMarketResultModel({
    this.id,
    this.gameName,
    this.digit,

    this.timestamp,
    this.v,
  });

  factory GaliMarketResultModel.fromMap(Map<String, dynamic> data) {
    return GaliMarketResultModel(
      id: data['_id'] as String?,
      gameName: data['gameName'] as String?,
      digit: data['digit'] as String?,

      timestamp: data['timestamp'] == null
          ? null
          : DateTime.parse(data['timestamp'] as String),
      v: data['__v'] as int?,
    );
  }

  Map<String, dynamic> toMap() => {
        '_id': id,
        'gameName': gameName,
        'digit': digit,

        'timestamp': timestamp?.toIso8601String(),
        '__v': v,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [GaliMarketResultModel].
  factory GaliMarketResultModel.fromJson(String data) {
    return GaliMarketResultModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [GaliMarketResultModel] to a JSON string.
  String toJson() => json.encode(toMap());

  GaliMarketResultModel copyWith({
    String? id,
    String? gameName,
    String? digit,

    DateTime? timestamp,
    int? v,
  }) {
    return GaliMarketResultModel(
      id: id ?? this.id,
      gameName: gameName ?? this.gameName,
      digit: digit ?? this.digit,

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
      digit,

      timestamp,
      v,
    ];
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
