
class LabelUnloadingModel {
  int? id;
  String? date;
  String? time;
  int? gateId;
  String? brandName;
  String? createdAt;
  String? createdBy;
  String? labelType;
  String? partyName;
  int? totalRoll;
  String? updatedAt;
  dynamic updatedBy;
  String? vehicleNo;
  int? bottleSize;
  int? totalLabel;
  dynamic warehouseId;
  int? brandNameId;
  int? labelTypeId;
  int? mappingLabel;
  int? partyNameId;
  int? rollPerCase;
  int? bottleSizeId;
  int? casesQuantity;
  int? labelPerRoll;
  int? rollAvailable;
  int? casesAvailable;
  int? labelAvailable;
  String? palletUniqueCode;

  LabelUnloadingModel({this.id, this.date, this.time, this.gateId, this.brandName, this.createdAt, this.createdBy, this.labelType, this.partyName, this.totalRoll, this.updatedAt, this.updatedBy, this.vehicleNo, this.bottleSize, this.totalLabel, this.warehouseId, this.brandNameId, this.labelTypeId, this.mappingLabel, this.partyNameId, this.rollPerCase, this.bottleSizeId, this.casesQuantity, this.labelPerRoll, this.rollAvailable, this.casesAvailable, this.labelAvailable, this.palletUniqueCode});

  LabelUnloadingModel.fromJson(Map<String, dynamic> json) {
    if(json["id"] is int) {
      id = json["id"];
    }
    if(json["date"] is String) {
      date = json["date"];
    }
    if(json["time"] is String) {
      time = json["time"];
    }
    if(json["gate_id"] is int) {
      gateId = json["gate_id"];
    }
    if(json["brand_name"] is String) {
      brandName = json["brand_name"];
    }
    if(json["created_at"] is String) {
      createdAt = json["created_at"];
    }
    if(json["created_by"] is String) {
      createdBy = json["created_by"];
    }
    if(json["label_type"] is String) {
      labelType = json["label_type"];
    }
    if(json["party_name"] is String) {
      partyName = json["party_name"];
    }
    if(json["total_roll"] is int) {
      totalRoll = json["total_roll"];
    }
    if(json["updated_at"] is String) {
      updatedAt = json["updated_at"];
    }
    updatedBy = json["updated_by"];
    if(json["vehicle_no"] is String) {
      vehicleNo = json["vehicle_no"];
    }
    if(json["bottle_size"] is int) {
      bottleSize = json["bottle_size"];
    }
    if(json["total_label"] is int) {
      totalLabel = json["total_label"];
    }
    warehouseId = json["warehouse_id"];
    if(json["brand_name_id"] is int) {
      brandNameId = json["brand_name_id"];
    }
    if(json["label_type_id"] is int) {
      labelTypeId = json["label_type_id"];
    }
    if(json["mapping_label"] is int) {
      mappingLabel = json["mapping_label"];
    }
    if(json["party_name_id"] is int) {
      partyNameId = json["party_name_id"];
    }
    if(json["roll_per_case"] is int) {
      rollPerCase = json["roll_per_case"];
    }
    if(json["bottle_size_id"] is int) {
      bottleSizeId = json["bottle_size_id"];
    }
    if(json["cases_quantity"] is int) {
      casesQuantity = json["cases_quantity"];
    }
    if(json["label_per_roll"] is int) {
      labelPerRoll = json["label_per_roll"];
    }
    if(json["roll_available"] is int) {
      rollAvailable = json["roll_available"];
    }
    if(json["cases_available"] is int) {
      casesAvailable = json["cases_available"];
    }
    if(json["label_available"] is int) {
      labelAvailable = json["label_available"];
    }
    if(json["pallet_unique_code"] is String) {
      palletUniqueCode = json["pallet_unique_code"];
    }
  }

  static List<LabelUnloadingModel> fromList(List<Map<String, dynamic>> list) {
    return list.map(LabelUnloadingModel.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["date"] = date;
    _data["time"] = time;
    _data["gate_id"] = gateId;
    _data["brand_name"] = brandName;
    _data["created_at"] = createdAt;
    _data["created_by"] = createdBy;
    _data["label_type"] = labelType;
    _data["party_name"] = partyName;
    _data["total_roll"] = totalRoll;
    _data["updated_at"] = updatedAt;
    _data["updated_by"] = updatedBy;
    _data["vehicle_no"] = vehicleNo;
    _data["bottle_size"] = bottleSize;
    _data["total_label"] = totalLabel;
    _data["warehouse_id"] = warehouseId;
    _data["brand_name_id"] = brandNameId;
    _data["label_type_id"] = labelTypeId;
    _data["mapping_label"] = mappingLabel;
    _data["party_name_id"] = partyNameId;
    _data["roll_per_case"] = rollPerCase;
    _data["bottle_size_id"] = bottleSizeId;
    _data["cases_quantity"] = casesQuantity;
    _data["label_per_roll"] = labelPerRoll;
    _data["roll_available"] = rollAvailable;
    _data["cases_available"] = casesAvailable;
    _data["label_available"] = labelAvailable;
    _data["pallet_unique_code"] = palletUniqueCode;
    return _data;
  }
}