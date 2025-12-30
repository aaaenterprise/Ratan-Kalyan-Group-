import 'dart:convert';



// ignore: must_be_immutable
class UserModel  {
  final String? id;
  final String? name;
  final String? phone;
  final String? password;
  final String? role;
  final num? wallet;
  final bool? active;
  final bool? verify;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  String? token;
  String? payment;

  UserModel({
    this.id,
    this.name,
    this.phone,
    this.password,
    this.role,
    this.wallet,
    this.active,
    this.verify,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.token,
    this.payment,
  });

  factory UserModel.fromMap(Map<String, dynamic> data) => UserModel(
        id: data['id'] as String?,
        name: data['name'] as String?,
        phone: data['phone'] as String?,
        password: data['password'] as String?,
        role: data['role'] as String?,
        wallet: data['wallet'] as num?,
        active: data['active'] as bool?,
        verify: data['verify'] as bool?,
        createdAt: data['createdAt'] == null
            ? null
            : DateTime.parse(data['createdAt'] as String),
        updatedAt: data['updatedAt'] == null
            ? null
            : DateTime.parse(data['updatedAt'] as String),
        v: data['__v'] as int?,
        token: data['token'] as String?,
        payment: data['payment'] as String?,
      );

  Map<String, dynamic> toMap() => {
        '_id': id,
        'name': name,
        'phone': phone,
        'password': password,
        'role': role,
        'wallet': wallet,
        'active': active,
        'verify': verify,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        '__v': v,
        'token': token,
        'payment': payment,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [UserModel].
  factory UserModel.fromJson(String data) {
    return UserModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [UserModel] to a JSON string.
  String toJson() => json.encode(toMap());

  UserModel copyWith({
    String? id,
    String? name,
    String? phone,
    String? password,
    String? role,
    num? wallet,
    bool? active,
    bool? verify,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
    String? token,
    String? payment,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      role: role ?? this.role,
      wallet: wallet ?? this.wallet,
      active: active ?? this.active,
      verify: verify ?? this.verify,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      v: v ?? this.v,
      token: token ?? this.token,
      payment: payment ?? this.payment,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      name,
      phone,
      password,
      role,
      wallet,
      active,
      verify,
      createdAt,
      updatedAt,
      v,
      token,
      payment,
    ];
  }
}
