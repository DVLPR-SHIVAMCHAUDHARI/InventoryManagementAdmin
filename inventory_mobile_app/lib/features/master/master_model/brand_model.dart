
class BrandModel {
  int? id;
  String? name;
  int? isDeleted;
  int? createdBy;
  String? createdAt;

  BrandModel({this.id, this.name, this.isDeleted, this.createdBy, this.createdAt});

  BrandModel.fromJson(Map<String, dynamic> json) {
    if(json["id"] is int) {
      id = json["id"];
    }
    if(json["name"] is String) {
      name = json["name"];
    }
    if(json["is_deleted"] is int) {
      isDeleted = json["is_deleted"];
    }
    if(json["created_by"] is int) {
      createdBy = json["created_by"];
    }
    if(json["created_at"] is String) {
      createdAt = json["created_at"];
    }
  }

  static List<BrandModel> fromList(List<Map<String, dynamic>> list) {
    return list.map(BrandModel.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["name"] = name;
    _data["is_deleted"] = isDeleted;
    _data["created_by"] = createdBy;
    _data["created_at"] = createdAt;
    return _data;
  }
}