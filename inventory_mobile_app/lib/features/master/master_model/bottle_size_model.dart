
class BottleSizeModel {
  int? id;
  int? size;
  int? isDeleted;
  int? createdBy;
  String? createdAt;

  BottleSizeModel({this.id, this.size, this.isDeleted, this.createdBy, this.createdAt});

  BottleSizeModel.fromJson(Map<String, dynamic> json) {
    if(json["id"] is int) {
      id = json["id"];
    }
    if(json["size"] is int) {
      size = json["size"];
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

  static List<BottleSizeModel> fromList(List<Map<String, dynamic>> list) {
    return list.map(BottleSizeModel.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["size"] = size;
    _data["is_deleted"] = isDeleted;
    _data["created_by"] = createdBy;
    _data["created_at"] = createdAt;
    return _data;
  }
}