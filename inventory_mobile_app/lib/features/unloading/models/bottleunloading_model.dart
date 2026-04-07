
class BottleUnloadingModel {
  int? id;
  String? date;
  String? time;
  int? gateId;
  int? boxSize;
  String? brandName;
  String? createdAt;
  String? createdBy;
  String? partyName;
  String? updatedAt;
  String? updatedBy;
  String? vehicleNo;
  int? bottleSize;
  int? boxSizeId;
  int? totalBottle;
  dynamic warehouseId;
  int? brandNameId;
  int? partyNameId;
  int? bottleSizeId;
  int? casesQuantity;
  int? mappingBottle;
  int? casesAvailable;
  int? bottleAvailable;
  String? palletUniqueCode;
  int? combinationBottleBoxes;

  BottleUnloadingModel({this.id, this.date, this.time, this.gateId, this.boxSize, this.brandName, this.createdAt, this.createdBy, this.partyName, this.updatedAt, this.updatedBy, this.vehicleNo, this.bottleSize, this.boxSizeId, this.totalBottle, this.warehouseId, this.brandNameId, this.partyNameId, this.bottleSizeId, this.casesQuantity, this.mappingBottle, this.casesAvailable, this.bottleAvailable, this.palletUniqueCode, this.combinationBottleBoxes});

  BottleUnloadingModel.fromJson(Map<String, dynamic> json) {
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
    if(json["box_size"] is int) {
      boxSize = json["box_size"];
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
    if(json["party_name"] is String) {
      partyName = json["party_name"];
    }
    if(json["updated_at"] is String) {
      updatedAt = json["updated_at"];
    }
    if(json["updated_by"] is String) {
      updatedBy = json["updated_by"];
    }
    if(json["vehicle_no"] is String) {
      vehicleNo = json["vehicle_no"];
    }
    if(json["bottle_size"] is int) {
      bottleSize = json["bottle_size"];
    }
    if(json["box_size_id"] is int) {
      boxSizeId = json["box_size_id"];
    }
    if(json["total_bottle"] is int) {
      totalBottle = json["total_bottle"];
    }
    warehouseId = json["warehouse_id"];
    if(json["brand_name_id"] is int) {
      brandNameId = json["brand_name_id"];
    }
    if(json["party_name_id"] is int) {
      partyNameId = json["party_name_id"];
    }
    if(json["bottle_size_id"] is int) {
      bottleSizeId = json["bottle_size_id"];
    }
    if(json["cases_quantity"] is int) {
      casesQuantity = json["cases_quantity"];
    }
    if(json["mapping_bottle"] is int) {
      mappingBottle = json["mapping_bottle"];
    }
    if(json["cases_available"] is int) {
      casesAvailable = json["cases_available"];
    }
    if(json["bottle_available"] is int) {
      bottleAvailable = json["bottle_available"];
    }
    if(json["pallet_unique_code"] is String) {
      palletUniqueCode = json["pallet_unique_code"];
    }
    if(json["combination_bottle_boxes"] is int) {
      combinationBottleBoxes = json["combination_bottle_boxes"];
    }
  }

  static List<BottleUnloadingModel> fromList(List<Map<String, dynamic>> list) {
    return list.map(BottleUnloadingModel.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["date"] = date;
    _data["time"] = time;
    _data["gate_id"] = gateId;
    _data["box_size"] = boxSize;
    _data["brand_name"] = brandName;
    _data["created_at"] = createdAt;
    _data["created_by"] = createdBy;
    _data["party_name"] = partyName;
    _data["updated_at"] = updatedAt;
    _data["updated_by"] = updatedBy;
    _data["vehicle_no"] = vehicleNo;
    _data["bottle_size"] = bottleSize;
    _data["box_size_id"] = boxSizeId;
    _data["total_bottle"] = totalBottle;
    _data["warehouse_id"] = warehouseId;
    _data["brand_name_id"] = brandNameId;
    _data["party_name_id"] = partyNameId;
    _data["bottle_size_id"] = bottleSizeId;
    _data["cases_quantity"] = casesQuantity;
    _data["mapping_bottle"] = mappingBottle;
    _data["cases_available"] = casesAvailable;
    _data["bottle_available"] = bottleAvailable;
    _data["pallet_unique_code"] = palletUniqueCode;
    _data["combination_bottle_boxes"] = combinationBottleBoxes;
    return _data;
  }
}