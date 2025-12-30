import 'dart:convert';

import 'package:equatable/equatable.dart';

class GaliBettingHistoryModel extends Equatable {
  final String? id;
  final String? userId;
  final String? gameName;
  final String? betType;
  final int? betAmount;
  final String? betNumber;
  final String? betTime;
  final DateTime? timestamp;

  const GaliBettingHistoryModel({
    this.id,
    this.userId,
    this.gameName,
    this.betType,
    this.betAmount,
    this.betNumber,
    this.betTime,
    this.timestamp,
  });

  factory GaliBettingHistoryModel.fromMap(Map<String, dynamic> data) {
    return GaliBettingHistoryModel(
      id: data['_id'] as String?,
      userId: data['userId'] as String?,
      gameName: data['gameName'] as String?,
      betType: data['betType'] as String?,
      betAmount: data['betAmount'] as int?,
      betNumber: data['betNumber'] as String,
      betTime: data['betTime'] as String?,
      timestamp: data['timestamp'] == null
          ? null
          : DateTime.parse(data['timestamp'] as String),
    );
  }

  Map<String, dynamic> toMap() => {
        if (id != null) '_id': id,
        'userId': userId,
        'gameName': gameName,
        'betType': betType,
        'betAmount': betAmount,
        'betNumber': betNumber,
        'betTime': betTime,
        if (timestamp != null) 'timestamp': timestamp?.toIso8601String(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [GaliBettingHistoryModel].
  factory GaliBettingHistoryModel.fromJson(String data) {
    return GaliBettingHistoryModel.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [GaliBettingHistoryModel] to a JSON string.
  String toJson() => json.encode(toMap());

  GaliBettingHistoryModel copyWith({
    String? id,
    String? userId,
    String? gameName,
    String? betType,
    int? betAmount,
    String? betNumber,
    String? betTime,
    DateTime? timestamp,
  }) {
    return GaliBettingHistoryModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      gameName: gameName ?? this.gameName,
      betType: betType ?? this.betType,
      betAmount: betAmount ?? this.betAmount,
      betNumber: betNumber ?? this.betNumber,
      betTime: betTime ?? this.betTime,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      userId,
      gameName,
      betType,
      betAmount,
      betNumber,
      betTime,
      timestamp,
    ];
  }
}
