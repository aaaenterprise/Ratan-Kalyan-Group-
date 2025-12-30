import 'dart:convert';



class ImageSlideModel {
  final String? id;
  final String? file;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  const ImageSlideModel({
    this.id,
    this.file,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory ImageSlideModel.fromMap(Map<String, dynamic> data) {
    return ImageSlideModel(
      id: data['_id'] as String?,
      file: data['file'] as String?,
      createdAt: data['createdAt'] == null
          ? null
          : DateTime.parse(data['createdAt'] as String),
      updatedAt: data['updatedAt'] == null
          ? null
          : DateTime.parse(data['updatedAt'] as String),
      v: data['__v'] as int?,
    );
  }

  Map<String, dynamic> toMap() => {
        '_id': id,
        'file': file,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        '__v': v,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ImageSlideModel].
  factory ImageSlideModel.fromJson(String data) {
    return ImageSlideModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [ImageSlideModel] to a JSON string.
  String toJson() => json.encode(toMap());

  ImageSlideModel copyWith({
    String? id,
    String? file,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
  }) {
    return ImageSlideModel(
      id: id ?? this.id,
      file: file ?? this.file,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      v: v ?? this.v,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [id, file, createdAt, updatedAt, v];
}
