import 'dart:convert';


class StarLineBetModel  {
  final String? id;
  final String? userId;
  final String? gameName;
  final String? betType;
  final int? betAmount;
  final String? betNumber;

  final DateTime? timestamp;
  final int? v;

  const StarLineBetModel({
    this.id,
    this.userId,
    this.gameName,
    this.betType,
    this.betAmount,
    this.betNumber,

    this.timestamp,
    this.v,
  });

  factory StarLineBetModel.fromMap(Map<String, dynamic> data) => StarLineBetModel(
        id: data['_id'] as String?,
        userId: data['userId'] as String?,
        gameName: data['gameName'] as String?,
        betType: data['betType'] as String?,
        betAmount: data['betAmount'] as int?,
        betNumber: data['betNumber'] as String,
        // betNumber: data['betNumber'].cast<String>(),

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

        'timestamp': timestamp?.toIso8601String(),
        '__v': v,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [BetModel].
  factory StarLineBetModel.fromJson(String data) {
    return StarLineBetModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [BetModel] to a JSON string.
  String toJson() => json.encode(toMap());

  StarLineBetModel copyWith({
    String? id,
    String? userId,
    String? gameName,
    String? betType,
    int? betAmount,
    String? betNumber,

    DateTime? timestamp,
    int? v,
  }) {
    return StarLineBetModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      gameName: gameName ?? this.gameName,
      betType: betType ?? this.betType,
      betAmount: betAmount ?? this.betAmount,
      betNumber: betNumber ?? this.betNumber,

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

      timestamp,
      v,
    ];
  }
}
