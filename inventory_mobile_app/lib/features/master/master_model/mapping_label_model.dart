class MappingLabelModel {
  int? id;
  int? brandNameId;
  int? labelTypeId;
  int? bottleSizeId;
  int? isDeleted;
  int? createdBy;
  String? createdAt;
  String? brandName;
  int? bottleSize;
  String? labelType;

  MappingLabelModel({
    this.id,
    this.brandNameId,
    this.labelTypeId,
    this.bottleSizeId,
    this.isDeleted,
    this.createdBy,
    this.createdAt,
    this.brandName,
    this.bottleSize,
    this.labelType,
  });

  MappingLabelModel.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) {
      id = json["id"];
    }
    if (json["brand_name_id"] is int) {
      brandNameId = json["brand_name_id"];
    }
    if (json["label_type_id"] is int) {
      labelTypeId = json["label_type_id"];
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
    if (json["label_type"] is String) {
      labelType = json["label_type"];
    }
  }

  static List<MappingLabelModel> fromList(List<Map<String, dynamic>> list) {
    return list.map(MappingLabelModel.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["brand_name_id"] = brandNameId;
    _data["label_type_id"] = labelTypeId;
    _data["bottle_size_id"] = bottleSizeId;
    _data["is_deleted"] = isDeleted;
    _data["created_by"] = createdBy;
    _data["created_at"] = createdAt;
    _data["brand_name"] = brandName;
    _data["bottle_size"] = bottleSize;
    _data["label_type"] = labelType;
    return _data;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MappingLabelModel &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
