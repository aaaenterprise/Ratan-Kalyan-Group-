import 'dart:convert';

import 'package:equatable/equatable.dart';

class GaliBetModel extends Equatable {
  final String? id;
  final String? userId;
  final String? gameName;
  final String? betType;
  final int? betAmount;
  final String? betNumber;
  final String? betTime;
  final DateTime? timestamp;
  final int? v;

  const GaliBetModel({
    this.id,
    this.userId,
    this.gameName,
    this.betType,
    this.betAmount,
    this.betNumber,
    this.betTime,
    this.timestamp,
    this.v,
  });

  factory GaliBetModel.fromMap(Map<String, dynamic> data) => GaliBetModel(
        id: data['_id'] as String?,
        userId: data['userId'] as String?,
        gameName: data['gameName'] as String?,
        betType: data['betType'] as String?,
        betAmount: data['betAmount'] as int?,
        betNumber: data['betNumber'] as String,
        // betNumber: data['betNumber'].cast<String>(),
        betTime: data['betTime'] as String?,
        timestamp: data['timestamp'] == null
            ? null
            : DateTime.parse(data['timestamp'] as String),
        v: data['__v'] as int?,
      );

  Map<String, dynamic> toMap() => {
        '_id': id,
        'userId': userId,
        'gameName': gameName,
        'betType': betType,
        'betAmount': betAmount,
        'betNumber': betNumber,
        'betTime': betTime,
        'timestamp': timestamp?.toIso8601String(),
        '__v': v,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [GaliBetModel].
  factory GaliBetModel.fromJson(String data) {
    return GaliBetModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [GaliBetModel] to a JSON string.
  String toJson() => json.encode(toMap());

  GaliBetModel copyWith({
    String? id,
    String? userId,
    String? gameName,
    String? betType,
    int? betAmount,
    String? betNumber,
    String? betTime,
    DateTime? timestamp,
    int? v,
  }) {
    return GaliBetModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      gameName: gameName ?? this.gameName,
      betType: betType ?? this.betType,
      betAmount: betAmount ?? this.betAmount,
      betNumber: betNumber ?? this.betNumber,
      betTime: betTime ?? this.betTime,
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
      userId,
      gameName,
      betType,
      betAmount,
      betNumber,
      betTime,
      timestamp,
      v,
    ];
  }
}
