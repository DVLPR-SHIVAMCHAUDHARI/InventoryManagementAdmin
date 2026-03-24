import 'package:inventory_mobile_app/core/services/dio_repo.dart';

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
}
