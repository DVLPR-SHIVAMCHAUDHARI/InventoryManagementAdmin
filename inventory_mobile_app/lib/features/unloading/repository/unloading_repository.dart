import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:inventory_mobile_app/core/services/dio_repo.dart';
import 'package:inventory_mobile_app/features/unloading/models/bottleunloading_model.dart';
import 'package:inventory_mobile_app/features/unloading/models/label_unloading_model.dart';

class UnloadingRepository extends Repository {
  Future<String> rawBottleEntry({
    required int gateId,
    required String palletUniqueCode,
    required int casesQuantity,
    required int mappingBottle,
    required int combinationBottleBoxes,
  }) async {
    final now = DateTime.now();
    final date = DateFormat('yyyy-MM-dd').format(now);
    final time = DateFormat('HH:mm').format(now);

    try {
      final response = await dio.post(
        "warehouse/unload-bottle",
        data: {
          "date": date,
          "time": time,
          "gate_id": gateId,
          "pallet_unique_code": palletUniqueCode,
          "cases_quantity": casesQuantity,
          "mapping_bottle": mappingBottle,
          "combination_bottle_boxes": combinationBottleBoxes,
        },
      );

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

  Future<String> updateBottleEntry({
    required int id,
    required int gateId,
    required String palletUniqueCode,
    required int casesQuantity,
    required int mappingBottle,
    required int combinationBottleBoxes,
  }) async {
    final now = DateTime.now();
    final date = DateFormat('yyyy-MM-dd').format(now);
    final time = DateFormat('HH:mm').format(now);

    try {
      final response = await dio.post(
        "warehouse/update-unload-bottle",
        data: {
          "date": date,
          "time": time,
          "gate_id": gateId,
          "pallet_unique_code": palletUniqueCode,
          "cases_quantity": casesQuantity,
          "mapping_bottle": mappingBottle,
          "combination_bottle_boxes": combinationBottleBoxes,
          "id": id,
        },
      );

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

  Future<String> deleteBottleEntry({required int id}) async {
    try {
      final response = await dio.post(
        "warehouse/delete-unload-bottle",
        data: {"id": id},
      );

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

  Future<List<BottleUnloadingModel>> fetchBottleUnloadingList({
    required String fromDate,
    required String toDate,
    String? palletCode,
    String? vehicleNo,
    String? partyName,
    int? brandName,
    int? bottleSize,
    String? sortBy,
    String orderBy = "asc",
    int offset = 1,
    int limit = 10,
  }) async {
    try {
      final response = await dio.get(
        "warehouse/list-unload-bottle",
        queryParameters: {
          "from_date": fromDate,
          "to_date": toDate,
          "pallet_unique_code": palletCode ?? "",
          "vehicle_no": vehicleNo ?? "",
          "party_name": partyName ?? "",
          "brand_name": brandName,
          "bottle_size": bottleSize,
          "sort_by": sortBy ?? "",
          "order_by": orderBy,
          "offset": offset,
          "limit": limit,
        },
      );

      final data = response.data["Response"]["ResponseData"];

      if (data["error"] == true) {
        throw Exception("Failed to fetch bottle unloading list");
      }

      final List list = data["list"];

      return list.map((e) => BottleUnloadingModel.fromJson(e)).toList();
    } catch (e) {
      throw Exception("Error fetching bottle unloading list: $e");
    }
  }

  Future<String> rawLabelEntry({
    required int gateId,
    required String palletUniqueCode,
    required int casesQuantity,
    required int mappingLabel,
    required int rollPerCase,
    required int labelPerRoll,
  }) async {
    final now = DateTime.now();
    final date = DateFormat('yyyy-MM-dd').format(now);
    final time = DateFormat('HH:mm').format(now);

    try {
      final response = await dio.post(
        "warehouse/unload-label",
        data: {
          "date": date,
          "time": time,
          "gate_id": gateId,
          "pallet_unique_code": palletUniqueCode,
          "cases_quantity": casesQuantity,
          "mapping_label": mappingLabel,
          "roll_per_case": rollPerCase,
          "label_per_roll": labelPerRoll,
        },
      );

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

  Future<String> updateLabelEntry({
    required int id,
    required int gateId,
    required String palletUniqueCode,
    required int casesQuantity,
    required int mappingLabel,
    required int rollPerCase,
    required int labelPerRoll,
  }) async {
    final now = DateTime.now();
    final date = DateFormat('yyyy-MM-dd').format(now);
    final time = DateFormat('HH:mm').format(now);

    try {
      final response = await dio.post(
        "warehouse/update-unload-label",
        data: {
          "date": date,
          "time": time,
          "gate_id": gateId,
          "pallet_unique_code": palletUniqueCode,
          "cases_quantity": casesQuantity,
          "mapping_label": mappingLabel,
          "roll_per_case": rollPerCase,
          "label_per_roll": labelPerRoll,
          "id": id,
        },
      );

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

  Future<String> deleteLabelEntry({required int id}) async {
    try {
      final response = await dio.post(
        "warehouse/delete-unload-label",
        data: {"id": id},
      );

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

  Future fetchLabelUnloadingList({
    required String fromDate,
    required String toDate,
    String? palletCode,
    String? vehicleNo,
    int? partyName,
    int? brandName,
    int? bottleSize,
    String? sortBy,
    String? orderBy = "asc",
    int offset = 1,
    int? limit = 10,
  }) async {
    try {
      final response = await dio.get(
        "warehouse/list-unload-label",
        queryParameters: {
          "from_date": fromDate,
          "to_date": toDate,

          if (palletCode != null && palletCode.isNotEmpty)
            "pallet_unique_code": palletCode,

          if (vehicleNo != null && vehicleNo.isNotEmpty)
            "vehicle_no": vehicleNo,

          if (partyName != null) "party_name": partyName,
          if (brandName != null) "brand_name": brandName,
          if (bottleSize != null) "bottle_size": bottleSize,

          "sort_by": sortBy ?? "",
          "order_by": orderBy,
          "offset": offset,
          "limit": limit,
        },
      );

      final data = response.data["Response"]["ResponseData"];

      if (data["error"] == true) {
        throw ("Failed to fetch label unloading list");
      }

      final List list = data["list"];

      return {
        "count": data["count"],
        "list": list.map((e) => LabelUnloadingModel.fromJson(e)).toList(),
      };
    } catch (e) {
      throw ("Error fetching label unloading list: $e");
    }
  }
}
