// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class GaliTodayResult {
  final String? id;
  final String? gameName;
  final String? digit;

  final DateTime? timestamp;

  const GaliTodayResult({
    this.id,
    this.gameName,
    this.digit,

    this.timestamp,
  });

  factory GaliTodayResult.fromMap(Map<String, dynamic> data) => GaliTodayResult(
        id: data['_id'] as String?,
        gameName: data['gameName'] as String?,
        digit: data['digit'] as String?,

        timestamp: data['timestamp'] == null
            ? null
            : DateTime.parse(data['timestamp'] as String),
      );

  Map<String, dynamic> toMap() => {
        '_id': id,
        'gameName': gameName,
        'digit': digit,

        'timestamp': timestamp?.toIso8601String(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [GaliTodayResult].
  factory GaliTodayResult.fromJson(String data) {
    return GaliTodayResult.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [GaliTodayResult] to a JSON string.
  String toJson() => json.encode(toMap());

  GaliTodayResult copyWith({
    String? id,
    String? gameName,
    String? digit,

    DateTime? timestamp,
  }) {
    return GaliTodayResult(
      id: id ?? this.id,
      gameName: gameName ?? this.gameName,
      digit: digit ?? this.digit,

      timestamp: timestamp ?? this.timestamp,
    );
  }

 

  @override
  List<Object?> get props {
    return [
      id,
      gameName,
      digit,

      timestamp,
    ];
  }



  @override
  String toString() {
    return 'GaliTodayResult(id: $id, gameName: $gameName, digit: $digit, timestamp: $timestamp)';
  }
}
