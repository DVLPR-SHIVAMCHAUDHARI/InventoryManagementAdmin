import 'package:inventory_mobile_app/core/services/dio_repo.dart';

class UnloadingRepository extends Repository {
  rawBottleEntry({
    palletUniqueCode,
    int? gateId,
    int? palletQuanitity,
    int? bottleId,
    int? rackId,
  }) async {
    final response = await dio.post(
      "staff/unload-bottle",
      data: {
        "gate_id": gateId ?? "",
        "pallet_unique_code": palletUniqueCode ?? "",
        "pallet_quantity": palletQuanitity ?? "",
        "bottle_id": bottleId,
        "warehouse_id": rackId,
      },
    );

    try {
      if (response.statusCode == 200 &&
          response.data["Response"]["Status"]["StatusCode"] == "0") {
        return response.data["Response"]["Status"]["DisplayText"];
      } else {
        throw response.data["Response"]["Status"]["DisplayText"];
      }
    } catch (e) {
      throw e.toString();
    }
  }

  rawCapEntry({
    palletUniqueCode,
    int? gateId,
    int? palletQuanitity,
    int? capId,
    int? rackId,
  }) async {
    final response = await dio.post(
      "staff/unload-cap",
      data: {
        "gate_id": gateId ?? "",
        "pallet_unique_code": palletUniqueCode ?? "",
        "pallet_quantity": palletQuanitity ?? "",
        "cap_id": capId,
        "warehouse_id": rackId,
      },
    );

    try {
      if (response.statusCode == 200 &&
          response.data["Response"]["Status"]["StatusCode"] == "0") {
        return response.data["Response"]["Status"]["DisplayText"];
      } else {
        throw response.data["Response"]["Status"]["DisplayText"];
      }
    } catch (e) {
      throw e.toString();
    }
  }

  rawLabelEntry({
    palletUniqueCode,
    int? gateId,
    int? palletQuanitity,
    int? labelId,
    int? rackId,
  }) async {
    final response = await dio.post(
      "staff/unload-lable",
      data: {
        "gate_id": gateId ?? "",
        "pallet_unique_code": palletUniqueCode ?? "",
        "pallet_quantity": palletQuanitity ?? "",
        "lable_id": labelId,
        "warehouse_id": rackId,
      },
    );

    try {
      if (response.statusCode == 200 &&
          response.data["Response"]["Status"]["StatusCode"] == "0") {
        return response.data["Response"]["Status"]["DisplayText"];
      } else {
        throw response.data["Response"]["Status"]["DisplayText"];
      }
    } catch (e) {
      throw e.toString();
    }
  }

  rawCartonEntry({
    palletUniqueCode,
    int? gateId,
    int? palletQuanitity,
    int? cartonId,
    int? rackId,
  }) async {
    final response = await dio.post(
      "staff/unload-carton",
      data: {
        "gate_id": gateId ?? "",
        "pallet_unique_code": palletUniqueCode ?? "",
        "pallet_quantity": palletQuanitity ?? "",
        "carton_id": cartonId,
        "warehouse_id": rackId,
      },
    );

    try {
      if (response.statusCode == 200 &&
          response.data["Response"]["Status"]["StatusCode"] == "0") {
        return response.data["Response"]["Status"]["DisplayText"];
      } else {
        throw response.data["Response"]["Status"]["DisplayText"];
      }
    } catch (e) {
      throw e.toString();
    }
  }

  rawMonoCartonEntry({
    palletUniqueCode,
    int? gateId,
    int? palletQuanitity,
    int? monoCartonId,
    int? rackId,
  }) async {
    final response = await dio.post(
      "staff/unload-mono-carton",
      data: {
        "gate_id": gateId ?? "",
        "pallet_unique_code": palletUniqueCode ?? "",
        "pallet_quantity": palletQuanitity ?? "",
        "mono_carton_id": monoCartonId,
        "warehouse_id": rackId,
      },
    );

    try {
      if (response.statusCode == 200 &&
          response.data["Response"]["Status"]["StatusCode"] == "0") {
        return response.data["Response"]["Status"]["DisplayText"];
      } else {
        throw response.data["Response"]["Status"]["DisplayText"];
      }
    } catch (e) {
      throw e.toString();
    }
  }
}
