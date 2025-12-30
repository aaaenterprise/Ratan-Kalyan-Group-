import 'dart:convert';



class GameRateModel  {
  final String? id;
  final String? userId;
  final int? singleDigit;
  final int? jodiDigit;
  final int? singlePana;
  final int? doublePana;
  final int? triplePana;
  final int? halfSangam;
  final int? fullSangam;

  const GameRateModel({
    this.id,
    this.userId,
    this.singleDigit,
    this.jodiDigit,
    this.singlePana,
    this.doublePana,
    this.triplePana,
    this.halfSangam,
    this.fullSangam,
  });

  factory GameRateModel.fromMap(Map<String, dynamic> data) => GameRateModel(
        id: data['_id'] as String?,
        userId: data['userId'] as String?,
        singleDigit: data['singleDigit'] as int?,
        jodiDigit: data['jodiDigit'] as int?,
        singlePana: data['singlePana'] as int?,
        doublePana: data['doublePana'] as int?,
        triplePana: data['triplePana'] as int?,
        halfSangam: data['halfSangam'] as int?,
        fullSangam: data['fullSangam'] as int?,
      );

  Map<String, dynamic> toMap() => {
        '_id': id,
        'userId': userId,
        'singleDigit': singleDigit,
        'jodiDigit': jodiDigit,
        'singlePana': singlePana,
        'doublePana': doublePana,
        'triplePana': triplePana,
        'halfSangam': halfSangam,
        'fullSangam': fullSangam,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [GameRateModel].
  factory GameRateModel.fromJson(String data) {
    return GameRateModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [GameRateModel] to a JSON string.
  String toJson() => json.encode(toMap());

  GameRateModel copyWith({
    String? id,
    String? userId,
    int? singleDigit,
    int? jodiDigit,
    int? singlePana,
    int? doublePana,
    int? triplePana,
    int? halfSangam,
    int? fullSangam,
  }) {
    return GameRateModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      singleDigit: singleDigit ?? this.singleDigit,
      jodiDigit: jodiDigit ?? this.jodiDigit,
      singlePana: singlePana ?? this.singlePana,
      doublePana: doublePana ?? this.doublePana,
      triplePana: triplePana ?? this.triplePana,
      halfSangam: halfSangam ?? this.halfSangam,
      fullSangam: fullSangam ?? this.fullSangam,
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
      singlePana,
      doublePana,
      triplePana,
      halfSangam,
      fullSangam,
    ];
  }
}
