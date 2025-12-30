import 'dart:convert';



class BetModel {
  final String? id;
  final String? userId;
  final String? gameName;
  final String? betType;
  final int? betAmount;
  final List<String>? betNumber;
  final String? betTime;
  final DateTime? timestamp;
  final int? v;

  const BetModel({
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

  factory BetModel.fromMap(Map<String, dynamic> data) => BetModel(
        id: data['_id'] as String?,
        userId: data['userId'] as String?,
        gameName: data['gameName'] as String?,
        betType: data['betType'] as String?,
        betAmount: data['betAmount'] as int?,
        betNumber: (data['betNumber'] as List).map((number) {
          if ((data['betType'] as String) == "Triple Pana" &&
              (number == 0 || number == '0')) {
            return "000";
          }
          return number.toString();
        }).toList(),
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
  /// Parses the string and returns the resulting Json object as [BetModel].
  factory BetModel.fromJson(String data) {
    return BetModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [BetModel] to a JSON string.
  String toJson() => json.encode(toMap());

  BetModel copyWith({
    String? id,
    String? userId,
    String? gameName,
    String? betType,
    int? betAmount,
    List<String>? betNumber,
    String? betTime,
    DateTime? timestamp,
    int? v,
  }) {
    return BetModel(
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
