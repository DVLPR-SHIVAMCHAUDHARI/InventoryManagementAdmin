import 'package:inventory_mobile_app/core/services/dio_repo.dart';
import 'package:inventory_mobile_app/features/gate_operations/gate_entries/models/gate_Entry_model.dart';

class GateEntryRepo extends Repository {
  Future<Map<String, dynamic>> gateEntry({
    required String date,
    required String time,
    required int truckType,
    required String vehicleNo,
    required String driverName,
    required String driverMobileNo,
    required int vehicleWeight,
    String? invoiceId,
    int? partyId,
  }) async {
    try {
      final Map<String, dynamic> body = {
        "date": date,
        "time": time,
        "truck_type": truckType,
        "driver_name": driverName,
        "vehicle_no": vehicleNo,
        "vehicle_weight": vehicleWeight,
        "driver_mobile_no": driverMobileNo,
      };

      // ✅ Only for filled truck
      if (truckType == 1) {
        body["invoice_id"] = invoiceId;
        body["party_name"] = partyId;
      }

      final response = await dio.post("/gate/create-gate-entry", data: body);

      if (response.statusCode != 200) {
        return {
          "success": false,
          "message": "Server error (${response.statusCode})",
        };
      }

      final data = response.data;

      final status = data["Response"]?["Status"]?["StatusCode"]?.toString();

      final message =
          data["Response"]?["Status"]?["DisplayText"] ?? "Unknown response";

      if (status != "0") {
        return {"success": false, "message": message};
      }

      return {"success": true, "message": message};
    } catch (e) {
      return {"success": false, "message": e.toString()};
    }
  }

  Future<List<GateEntryModel>> getGateEntries({
    required int truckType,
    required String date,
    String? vehicleNo,
    int? partyId,
    int offset = 1,
    int limit = 10,
  }) async {
    try {
      final queryParams = {
        "truck_type": truckType,
        "date": date,
        "offset": offset,
        "limit": limit,
        "sort_by": "vehicle_no",
        "order_by": "asc",
      };

      if (vehicleNo != null && vehicleNo.isNotEmpty) {
        queryParams["vehicle_no"] = vehicleNo;
      }

      if (truckType == 1 && partyId != null) {
        queryParams["party_name"] = partyId;
      }

      final response = await dio.get(
        "/gate/list-gate-entry",
        queryParameters: queryParams,
      );

      final data = response.data;

      final status = data["Response"]?["Status"]?["StatusCode"]?.toString();

      if (status != "0") {
        throw Exception(
          data["Response"]?["Status"]?["DisplayText"] ??
              "Failed to fetch entries",
        );
      }

      final list = data["Response"]?["ResponseData"]?["list"] ?? [];

      return (list as List).map((e) => GateEntryModel.fromJson(e)).toList();
    } catch (e) {
      throw Exception("Failed to fetch gate entries: $e");
    }
  }

  Future<Map<String, dynamic>> updateGateEntry({
    required int id,
    required String date,
    required String time,
    required int truckType,
    required String driverName,
    required String vehicleNo,
    required int vehicleWeight,
    required String driverMobileNo,
    String? invoiceId,
    int? partyId,
  }) async {
    try {
      final Map<String, dynamic> body = {
        "id": id,
        "date": date,
        "time": time,
        "truck_type": truckType,
        "driver_name": driverName,
        "vehicle_no": vehicleNo,
        "vehicle_weight": vehicleWeight,
        "driver_mobile_no": driverMobileNo,
      };

      if (truckType == 1) {
        if (invoiceId != null) body["invoice_id"] = invoiceId;
        if (partyId != null) body["party_name"] = partyId;
      }
      final response = await dio.post("/gate/update-gate-entry", data: body);

      final data = response.data;

      final status = data["Response"]?["Status"]?["StatusCode"]?.toString();

      final message =
          data["Response"]?["Status"]?["DisplayText"] ?? "Unknown response";

      if (status != "0") {
        return {"success": false, "message": message};
      }

      return {"success": true, "message": message};
    } catch (e) {
      return {"success": false, "message": e.toString()};
    }
  }

  Future<Map<String, dynamic>> deleteGateEntry({
    required int id,
    required int truckType,
  }) async {
    try {
      final body = {"id": id, "truck_type": truckType};

      final response = await dio.post("/gate/delete-gate-entry", data: body);

      final data = response.data;

      final status = data["Response"]?["Status"]?["StatusCode"]?.toString();

      final message =
          data["Response"]?["Status"]?["DisplayText"] ?? "Unknown response";

      if (status != "0") {
        return {"success": false, "message": message};
      }

      return {"success": true, "message": message};
    } catch (e) {
      return {"success": false, "message": e.toString()};
    }
  }
}
