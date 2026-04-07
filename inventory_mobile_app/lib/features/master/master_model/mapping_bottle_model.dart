class MappingBottleModel {
  int? id;
  int? brandNameId;
  int? bottleSizeId;
  int? isDeleted;
  int? createdBy;
  String? createdAt;
  String? brandName;
  int? bottleSize;

  MappingBottleModel({
    this.id,
    this.brandNameId,
    this.bottleSizeId,
    this.isDeleted,
    this.createdBy,
    this.createdAt,
    this.brandName,
    this.bottleSize,
  });

  MappingBottleModel.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) {
      id = json["id"];
    }
    if (json["brand_name_id"] is int) {
      brandNameId = json["brand_name_id"];
    }
    if (json["bottle_size_id"] is int) {
      bottleSizeId = json["bottle_size_id"];
    }
    if (json["is_deleted"] is int) {
      isDeleted = json["is_deleted"];
    }
    if (json["created_by"] is int) {
      createdBy = json["created_by"];
    }
    if (json["created_at"] is String) {
      createdAt = json["created_at"];
    }
    if (json["brand_name"] is String) {
      brandName = json["brand_name"];
    }
    if (json["bottle_size"] is int) {
      bottleSize = json["bottle_size"];
    }
  }

  static List<MappingBottleModel> fromList(List<Map<String, dynamic>> list) {
    return list.map(MappingBottleModel.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["brand_name_id"] = brandNameId;
    _data["bottle_size_id"] = bottleSizeId;
    _data["is_deleted"] = isDeleted;
    _data["created_by"] = createdBy;
    _data["created_at"] = createdAt;
    _data["brand_name"] = brandName;
    _data["bottle_size"] = bottleSize;
    return _data;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MappingBottleModel &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
