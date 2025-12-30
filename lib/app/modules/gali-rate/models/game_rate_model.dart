import 'dart:convert';

import 'package:equatable/equatable.dart';

class GaliGameRateModel extends Equatable {
  final String? id;
  final String? userId;
  final int? singleDigit;
  final int? jodiDigit;


  const GaliGameRateModel({
    this.id,
    this.userId,
    this.singleDigit,
    this.jodiDigit,

  });

  factory GaliGameRateModel.fromMap(Map<String, dynamic> data) => GaliGameRateModel(
        id: data['_id'] as String?,
        userId: data['userId'] as String?,
        singleDigit: data['singleDigit'] as int?,
        jodiDigit: data['jodiDigit'] as int?,

      );

  Map<String, dynamic> toMap() => {
        '_id': id,
        'userId': userId,
        'singleDigit': singleDigit,
        'jodiDigit': jodiDigit,

      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [GaliGameRateModel].
  factory GaliGameRateModel.fromJson(String data) {
    return GaliGameRateModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [GaliGameRateModel] to a JSON string.
  String toJson() => json.encode(toMap());

  GaliGameRateModel copyWith({
    String? id,
    String? userId,
    int? singleDigit,
    int? jodiDigit,

  }) {
    return GaliGameRateModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      singleDigit: singleDigit ?? this.singleDigit,
      jodiDigit: jodiDigit ?? this.jodiDigit,

    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      userId,
      singleDigit,
      jodiDigit,

    ];
  }
}
