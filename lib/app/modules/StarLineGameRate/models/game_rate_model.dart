import 'dart:convert';


class StarLineGameRateModel  {
  final String? id;
  final String? userId;
  final int? singleDigit;

  final int? singlePana;
  final int? doublePana;
  final int? triplePana;


  const StarLineGameRateModel({
    this.id,
    this.userId,
    this.singleDigit,

    this.singlePana,
    this.doublePana,
    this.triplePana,

  });

  factory StarLineGameRateModel.fromMap(Map<String, dynamic> data) => StarLineGameRateModel(
        id: data['_id'] as String?,
        userId: data['userId'] as String?,
        singleDigit: data['singleDigit'] as int?,

        singlePana: data['singlePana'] as int?,
        doublePana: data['doublePana'] as int?,
        triplePana: data['triplePana'] as int?,

      );

  Map<String, dynamic> toMap() => {
        '_id': id,
        'userId': userId,
        'singleDigit': singleDigit,

        'singlePana': singlePana,
        'doublePana': doublePana,
        'triplePana': triplePana,

      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [StarLineGameRateModel].
  factory StarLineGameRateModel.fromJson(String data) {
    return StarLineGameRateModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [StarLineGameRateModel] to a JSON string.
  String toJson() => json.encode(toMap());

  StarLineGameRateModel copyWith({
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
    return StarLineGameRateModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      singleDigit: singleDigit ?? this.singleDigit,

      singlePana: singlePana ?? this.singlePana,
      doublePana: doublePana ?? this.doublePana,
      triplePana: triplePana ?? this.triplePana,

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
   
      singlePana,
      doublePana,
      triplePana,

    ];
  }
}
