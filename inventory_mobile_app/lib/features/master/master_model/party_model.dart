class PartyModel {
  int? id;
  String? name;
  int? isDeleted;
  int? createdBy;
  String? createdAt;

  PartyModel({
    this.id,
    this.name,
    this.isDeleted,
    this.createdBy,
    this.createdAt,
  });

  PartyModel.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) {
      id = json["id"];
    }
    if (json["name"] is String) {
      name = json["name"];
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
  }

  static List<PartyModel> fromList(List<Map<String, dynamic>> list) {
    return list.map(PartyModel.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["is_deleted"] = isDeleted;
    data["created_by"] = createdBy;
    data["created_at"] = createdAt;
    return data;
  }
}
