import 'dart:convert';



class TransactionModel  {
  final String? id;
  final String? userId;
  final num? amount;
  final String? type;
  final String? description;
  final DateTime? timestamp;
  final int? v;

  const TransactionModel({
    this.id,
    this.userId,
    this.amount,
    this.type,
    this.description,
    this.timestamp,
    this.v,
  });

  factory TransactionModel.fromMap(Map<String, dynamic> data) {
    return TransactionModel(
      id: data['_id'] as String?,
      userId: data['userId'] as String?,
      amount: data['amount'] as num?,
      type: data['type'] as String?,
      description: data['description'] as String?,
      timestamp: data['timestamp'] == null
          ? null
          : DateTime.parse(data['timestamp'] as String),
      v: data['__v'] as int?,
    );
  }

  Map<String, dynamic> toMap() => {
        '_id': id,
        'userId': userId,
        'amount': amount,
        'type': type,
        'description': description,
        'timestamp': timestamp?.toIso8601String(),
        '__v': v,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [TransactionModel].
  factory TransactionModel.fromJson(String data) {
    return TransactionModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [TransactionModel] to a JSON string.
  String toJson() => json.encode(toMap());

  TransactionModel copyWith({
    String? id,
    String? userId,
    num? amount,
    String? type,
    String? description,
    DateTime? timestamp,
    int? v,
  }) {
    return TransactionModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      amount: amount ?? this.amount,
      type: type ?? this.type,
      description: description ?? this.description,
      timestamp: timestamp ?? this.timestamp,
      v: v ?? this.v,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      userId,
      amount,
      type,
      description,
      timestamp,
      v,
    ];
  }
}
