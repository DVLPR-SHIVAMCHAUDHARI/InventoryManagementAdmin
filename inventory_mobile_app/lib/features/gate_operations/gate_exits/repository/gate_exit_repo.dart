import 'package:inventory_mobile_app/core/services/dio_repo.dart';
import 'package:inventory_mobile_app/features/gate_operations/gate_exits/model/gate_exit_model.dart';

class GateExitRepo extends Repository {
  Future<Map<String, dynamic>> gateExit({
    required int id,
    required String exitDate,
    required String exitTime,
    required int truckType,
    required int outVehicleWeight,
  }) async {
    try {
      final response = await dio.post(
        "/gate/create-gate-exit",
        data: {
          "id": id,
          "exit_date": exitDate,
          "exit_time": exitTime,
          "truck_type": truckType,
          "in_plant": 2,
          "out_vehicle_weight": outVehicleWeight,
        },
      );

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

  Future<List<GateExitModel>> listGateExit({
    required int truckType,
    required String exitDate,
    String vehicleNo = '',
    String partyName = '',
    String sortBy = 'vehicle_no',
    String orderBy = 'asc',
    int offset = 1,
    int limit = 10,
  }) async {
    try {
      final response = await dio.get(
        "/gate/list-gate-exit",
        queryParameters: {
          "truck_type": truckType,
          "exit_date": exitDate,
          "vehicle_no": vehicleNo,
          "party_name": partyName,
          "sort_by": sortBy,
          "order_by": orderBy,
          "offset": offset,
          "limit": limit,
        },
      );
      final status = response.data["Response"]?["Status"]?["StatusCode"]
          ?.toString();
      if (status == "0") {
        final list = response.data["Response"]["ResponseData"]["list"] as List;
        return list.map((e) => GateExitModel.fromJson(e)).toList();
      } else {
        throw response.data["Response"]["Status"]["DisplayText"];
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<Map<String, dynamic>> updateGateExit({
    required int id,
    required int truckType,
    required int outVehicleWeight,
  }) async {
    try {
      final response = await dio.post(
        "/gate/update-gate-exit",
        data: {
          "id": id,
          "truck_type": truckType,
          "in_plant": 1,
          "out_vehicle_weight": outVehicleWeight,
        },
      );
      final status = response.data["Response"]?["Status"]?["StatusCode"]
          ?.toString();
      final message =
          response.data["Response"]?["Status"]?["DisplayText"] ?? "Unknown";
      return {"success": status == "0", "message": message};
    } catch (e) {
      return {"success": false, "message": e.toString()};
    }
  }

  Future<Map<String, dynamic>> deleteGateExit({
    required int id,
    required int truckType,
  }) async {
    try {
      final response = await dio.post(
        "/gate/delete-gate-exit",
        data: {"id": id, "truck_type": truckType},
      );
      final status = response.data["Response"]?["Status"]?["StatusCode"]
          ?.toString();
      final message =
          response.data["Response"]?["Status"]?["DisplayText"] ?? "Unknown";
      return {"success": status == "0", "message": message};
    } catch (e) {
      return {"success": false, "message": e.toString()};
    }
  }
}
