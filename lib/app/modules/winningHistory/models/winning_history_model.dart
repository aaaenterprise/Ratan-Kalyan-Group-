import 'dart:convert';



class WinningHistoryModel {
  final String? id;
  final String? userId;
  final String? gameName;
  final String? betType;
  final int? betAmount;
  final num? winningAmount;
  final DateTime? timestamp;

  const WinningHistoryModel({
    this.id,
    this.userId,
    this.gameName,
    this.betType,
    this.betAmount,
    this.winningAmount,
    this.timestamp,
  });

  factory WinningHistoryModel.fromMap(Map<String, dynamic> data) {
    return WinningHistoryModel(
      id: data['_id'] as String?,
      userId: data['userId'] as String?,
      gameName: data['gameName'] as String?,
      betType: data['betType'] as String?,
      betAmount: data['betAmount'] as int?,
      winningAmount: data['winningAmount'] as num?,
      timestamp: data['timestamp'] == null
          ? null
          : DateTime.parse(data['timestamp'] as String),
    );
  }

  Map<String, dynamic> toMap() => {
        '_id': id,
        'userId': userId,
        'gameName': gameName,
        'betType': betType,
        'betAmount': betAmount,
        'winningAmount': winningAmount,
        'timestamp': timestamp?.toIso8601String(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [WinningHistoryModel].
  factory WinningHistoryModel.fromJson(String data) {
    return WinningHistoryModel.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [WinningHistoryModel] to a JSON string.
  String toJson() => json.encode(toMap());

  WinningHistoryModel copyWith({
    String? id,
    String? userId,
    String? gameName,
    String? betType,
    int? betAmount,
    num? winningAmount,
    DateTime? timestamp,
  }) {
    return WinningHistoryModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      gameName: gameName ?? this.gameName,
      betType: betType ?? this.betType,
      betAmount: betAmount ?? this.betAmount,
      winningAmount: winningAmount ?? this.winningAmount,
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
      winningAmount,
      timestamp,
    ];
  }
}
