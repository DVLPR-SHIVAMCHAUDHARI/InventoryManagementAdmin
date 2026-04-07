class BottleCombinationModel {
  int? id;
  int? bottleSizeId;
  int? casesId;
  int? bottleSize;
  int? caseSize;

  BottleCombinationModel({
    this.id,
    this.bottleSizeId,
    this.casesId,
    this.bottleSize,
    this.caseSize,
  });

  BottleCombinationModel.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) {
      id = json["id"];
    }
    if (json["bottle_size_id"] is int) {
      bottleSizeId = json["bottle_size_id"];
    }
    if (json["cases_id"] is int) {
      casesId = json["cases_id"];
    }
    if (json["bottle_size"] is int) {
      bottleSize = json["bottle_size"];
    }
    if (json["case_size"] is int) {
      caseSize = json["case_size"];
    }
  }

  static List<BottleCombinationModel> fromList(
    List<Map<String, dynamic>> list,
  ) {
    return list.map(BottleCombinationModel.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["bottle_size_id"] = bottleSizeId;
    _data["cases_id"] = casesId;
    _data["bottle_size"] = bottleSize;
    _data["case_size"] = caseSize;
    return _data;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BottleCombinationModel &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
