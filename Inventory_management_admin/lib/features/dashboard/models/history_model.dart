
class HistoryModel {
  int? firstId;
  String? firstStageToDate;
  String? firstStageToTime;
  String? firstStageToUser;
  int? stillAssignedFirst;
  String? firstStageFromUser;
  String? firstStageToDepartment;
  String? firstStageFromDateTime;
  String? firstStageFromDepartment;
  int? secondId;
  String? secondStageToDate;
  String? secondStageToTime;
  String? secondStageToUser;
  int? stillAssignedSecond;
  String? assignedToPartyName;
  String? secondStageFromUser;
  String? secondStageToDepartment;
  String? assignedToCompanyAddress;
  String? secondStageFromDateTime;
  String? assignedToCompanyLocation;
  String? secondStageFromDepartment;

  HistoryModel({this.firstId, this.firstStageToDate, this.firstStageToTime, this.firstStageToUser, this.stillAssignedFirst, this.firstStageFromUser, this.firstStageToDepartment, this.firstStageFromDateTime, this.firstStageFromDepartment, this.secondId, this.secondStageToDate, this.secondStageToTime, this.secondStageToUser, this.stillAssignedSecond, this.assignedToPartyName, this.secondStageFromUser, this.secondStageToDepartment, this.assignedToCompanyAddress, this.secondStageFromDateTime, this.assignedToCompanyLocation, this.secondStageFromDepartment});

  HistoryModel.fromJson(Map<String, dynamic> json) {
    if(json["first_id"] is int) {
      firstId = json["first_id"];
    }
    if(json["first_stage_to_date"] is String) {
      firstStageToDate = json["first_stage_to_date"];
    }
    if(json["first_stage_to_time"] is String) {
      firstStageToTime = json["first_stage_to_time"];
    }
    if(json["first_stage_to_user"] is String) {
      firstStageToUser = json["first_stage_to_user"];
    }
    if(json["still_assigned_first"] is int) {
      stillAssignedFirst = json["still_assigned_first"];
    }
    if(json["first_stage_from_user"] is String) {
      firstStageFromUser = json["first_stage_from_user"];
    }
    if(json["first_stage_to_department"] is String) {
      firstStageToDepartment = json["first_stage_to_department"];
    }
    if(json["first_stage_from_date_time"] is String) {
      firstStageFromDateTime = json["first_stage_from_date_time"];
    }
    if(json["first_stage_from_department"] is String) {
      firstStageFromDepartment = json["first_stage_from_department"];
    }
    if(json["second_id"] is int) {
      secondId = json["second_id"];
    }
    if(json["second_stage_to_date"] is String) {
      secondStageToDate = json["second_stage_to_date"];
    }
    if(json["second_stage_to_time"] is String) {
      secondStageToTime = json["second_stage_to_time"];
    }
    if(json["second_stage_to_user"] is String) {
      secondStageToUser = json["second_stage_to_user"];
    }
    if(json["still_assigned_second"] is int) {
      stillAssignedSecond = json["still_assigned_second"];
    }
    if(json["assigned_to_party_name"] is String) {
      assignedToPartyName = json["assigned_to_party_name"];
    }
    if(json["second_stage_from_user"] is String) {
      secondStageFromUser = json["second_stage_from_user"];
    }
    if(json["second_stage_to_department"] is String) {
      secondStageToDepartment = json["second_stage_to_department"];
    }
    if(json["assigned_to_company_address"] is String) {
      assignedToCompanyAddress = json["assigned_to_company_address"];
    }
    if(json["second_stage_from_date_time"] is String) {
      secondStageFromDateTime = json["second_stage_from_date_time"];
    }
    if(json["assigned_to_company_location"] is String) {
      assignedToCompanyLocation = json["assigned_to_company_location"];
    }
    if(json["second_stage_from_department"] is String) {
      secondStageFromDepartment = json["second_stage_from_department"];
    }
  }

  static List<HistoryModel> fromList(List<Map<String, dynamic>> list) {
    return list.map(HistoryModel.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["first_id"] = firstId;
    _data["first_stage_to_date"] = firstStageToDate;
    _data["first_stage_to_time"] = firstStageToTime;
    _data["first_stage_to_user"] = firstStageToUser;
    _data["still_assigned_first"] = stillAssignedFirst;
    _data["first_stage_from_user"] = firstStageFromUser;
    _data["first_stage_to_department"] = firstStageToDepartment;
    _data["first_stage_from_date_time"] = firstStageFromDateTime;
    _data["first_stage_from_department"] = firstStageFromDepartment;
    _data["second_id"] = secondId;
    _data["second_stage_to_date"] = secondStageToDate;
    _data["second_stage_to_time"] = secondStageToTime;
    _data["second_stage_to_user"] = secondStageToUser;
    _data["still_assigned_second"] = stillAssignedSecond;
    _data["assigned_to_party_name"] = assignedToPartyName;
    _data["second_stage_from_user"] = secondStageFromUser;
    _data["second_stage_to_department"] = secondStageToDepartment;
    _data["assigned_to_company_address"] = assignedToCompanyAddress;
    _data["second_stage_from_date_time"] = secondStageFromDateTime;
    _data["assigned_to_company_location"] = assignedToCompanyLocation;
    _data["second_stage_from_department"] = secondStageFromDepartment;
    return _data;
  }
}