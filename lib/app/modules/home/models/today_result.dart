import 'dart:convert';



class TodayResult {
  final String? id;
  final String? gameName;
  final String? openPana;
  final String? closePana;
  final DateTime? timestamp;

  const TodayResult({
    this.id,
    this.gameName,
    this.openPana,
    this.closePana,
    this.timestamp,
  });

  factory TodayResult.fromMap(Map<String, dynamic> data) => TodayResult(
        id: data['_id'] as String?,
        gameName: data['gameName'] as String?,
        openPana: data['openPana'] as String?,
        closePana: data['closePana'] as String?,
        timestamp: data['timestamp'] == null
            ? null
            : DateTime.parse(data['timestamp'] as String),
      );

  Map<String, dynamic> toMap() => {
        '_id': id,
        'gameName': gameName,
        'openPana': openPana,
        'closePana': closePana,
        'timestamp': timestamp?.toIso8601String(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [TodayResult].
  factory TodayResult.fromJson(String data) {
    return TodayResult.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [TodayResult] to a JSON string.
  String toJson() => json.encode(toMap());

  TodayResult copyWith({
    String? id,
    String? gameName,
    String? openPana,
    String? closePana,
    DateTime? timestamp,
  }) {
    return TodayResult(
      id: id ?? this.id,
      gameName: gameName ?? this.gameName,
      openPana: openPana ?? this.openPana,
      closePana: closePana ?? this.closePana,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      gameName,
      openPana,
      closePana,
      timestamp,
    ];
  }

  String calculateAnk() {
    String? openPanaAnk = calculateSingleAnk(openPana);
    String? closePanaAnk = calculateSingleAnk(closePana);

    // Concatenate the ank for openPana and closePana
    return '$openPanaAnk$closePanaAnk';
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
}
