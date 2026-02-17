import 'package:inventory_management_admin_pannel/core/Utils/repository.dart';

class MaterialManagementRepository extends Repository {
  createBottleEntry({
    int? size,
    partyName,
    int? totalBottlesPerCase,
    bottleStatus,
    bottleType,
  }) async {
    final response = await dio.post(
      "insert/master-bottle",
      data: {
        "size": size ?? "",
        "party_name": partyName ?? "",
        "total_bottle_per_case": totalBottlesPerCase ?? "",
        "bottle_status": bottleStatus ?? "",
        "bottle_type": bottleType ?? "",
      },
    );

    try {
      if (response.statusCode == 200 &&
          response.data["Response"]["Status"]["StatusCode"] == "0") {
        return response.data["Response"]["Status"]["DisplayText"];
      } else {
        throw Exception("Failed to create bottle entry");
      }
    } catch (e) {
      throw Exception("Error creating bottle entry: $e");
    }
  }

  updateBottleEntry({
    int? updateId,
    int? size,
    partyName,
    int? totalBottlePerCase,
    bottleStatus,
    bottleType,
  }) async {
    final response = await dio.post(
      "insert/update-master-bottle",
      data: {
        "update_id": updateId ?? "",
        "size": size ?? "",
        "party_name": partyName ?? "",
        "total_bottle_per_case": totalBottlePerCase ?? "",
        "bottle_status": bottleStatus ?? "",
        "bottle_type": bottleType ?? "",
      },
    );

    try {
      if (response.statusCode == 200 &&
          response.data["Response"]["Status"]["StatusCode"] == "0") {
        return response.data["Response"]["Status"]["DisplayText"];
      } else {
        throw (
          response.data["Response"]["Status"]["DisplayText"] ??
              "Failed to update bottle entry",
        );
      }
    } catch (e) {
      throw (" $e");
    }
  }

  deleteBottleEntry({int? bottleId}) async {
    final response = await dio.post(
      "insert/delete-master-bottle",
      data: {"bottle_id": bottleId ?? ""},
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

  createCapEntry({
    int? size,
    partyName,
    int? totalCapsPerCase,
    capStatus,
    capType,
  }) async {
    final response = await dio.post(
      "insert/master-cap",
      data: {
        "size": size ?? "",
        "party_name": partyName ?? "",
        "total_cap_per_case": totalCapsPerCase ?? "",
        "cap_status": capStatus ?? "",
        "cap_type": capType ?? "",
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

  updateCapEntry({
    int? updateId,
    int? size,
    partyName,
    int? totalCapsPerCase,
    capStatus,
    capType,
  }) async {
    final response = await dio.post(
      "insert/update-master-cap",
      data: {
        "update_id": updateId ?? "",
        "size": size ?? "",
        "party_name": partyName ?? "",
        "total_cap_per_case": totalCapsPerCase ?? "",
        "cap_status": capStatus ?? "",
        "cap_type": capType ?? "",
      },
    );

    try {
      if (response.statusCode == 200 &&
          response.data["Response"]["Status"]["StatusCode"] == "0") {
        return response.data["Response"]["Status"]["DisplayText"];
      } else {
        throw (
          response.data["Response"]["Status"]["DisplayText"] ??
              "Failed to update cap entry",
        );
      }
    } catch (e) {
      throw (" $e");
    }
  }

  deleteCapEntry({int? capId}) async {
    final response = await dio.post(
      "insert/delete-master-cap",
      data: {"cap_id": capId ?? ""},
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

  ////////////////////////////////////////////////////////////
  /// CREATE lable ENTRY
  ////////////////////////////////////////////////////////////

  createlableEntry({
    int? size,
    partyName,
    int? totalLablePerCase,
    lableStatus,
    lableType,
  }) async {
    final response = await dio.post(
      "insert/master-lable",
      data: {
        "size": size ?? "",
        "party_name": partyName ?? "",
        "total_lable_per_case": totalLablePerCase ?? "",
        "lable_status": lableStatus ?? "",
        "lable_type": lableType ?? "",
      },
    );

    try {
      if (response.statusCode == 200 &&
          response.data["Response"]["Status"]["StatusCode"] == "0") {
        return response.data["Response"]["Status"]["DisplayText"];
      } else {
        throw response.data["Response"]["Status"]["DisplayText"] ??
            "Failed to create lable entry";
      }
    } catch (e) {
      throw e.toString();
    }
  }

  ////////////////////////////////////////////////////////////
  /// UPDATE lable ENTRY
  ////////////////////////////////////////////////////////////

  updatelableEntry({
    int? updateId,
    int? size,
    partyName,
    int? totalLablePerCase,
    lableStatus,
    lableType,
  }) async {
    final response = await dio.post(
      "insert/update-master-lable",
      data: {
        "update_id": updateId ?? "",
        "size": size ?? "",
        "party_name": partyName ?? "",
        "total_lable_per_case": totalLablePerCase ?? "",
        "lable_status": lableStatus ?? "",
        "lable_type": lableType ?? "",
      },
    );

    try {
      if (response.statusCode == 200 &&
          response.data["Response"]["Status"]["StatusCode"] == "0") {
        return response.data["Response"]["Status"]["DisplayText"];
      } else {
        throw response.data["Response"]["Status"]["DisplayText"] ??
            "Failed to update lable entry";
      }
    } catch (e) {
      throw e.toString();
    }
  }

  ////////////////////////////////////////////////////////////
  /// DELETE lable ENTRY
  ////////////////////////////////////////////////////////////

  deletelableEntry({int? lableId}) async {
    final response = await dio.post(
      "insert/delete-master-lable",
      data: {"lable_id": lableId ?? ""},
    );

    try {
      if (response.statusCode == 200 &&
          response.data["Response"]["Status"]["StatusCode"] == "0") {
        return response.data["Response"]["Status"]["DisplayText"];
      } else {
        throw response.data["Response"]["Status"]["DisplayText"] ??
            "Failed to delete lable entry";
      }
    } catch (e) {
      throw e.toString();
    }
  }

  ////////////////////////////////////////////////////////////
  /// CREATE CARTON
  ////////////////////////////////////////////////////////////

  createCartonEntry({
    int? size,
    partyName,
    int? totalCartonPerCase,
    cartonStatus,
    cartonType,
  }) async {
    final response = await dio.post(
      "insert/master-carton",
      data: {
        "size": size ?? "",
        "party_name": partyName ?? "",
        "total_carton_per_case": totalCartonPerCase ?? "",
        "carton_status": cartonStatus ?? "",
        "carton_type": cartonType ?? "",
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

  ////////////////////////////////////////////////////////////
  /// UPDATE CARTON
  ////////////////////////////////////////////////////////////

  updateCartonEntry({
    int? updateId,
    int? size,
    partyName,
    int? totalCartonPerCase,
    cartonStatus,
    cartonType,
  }) async {
    final response = await dio.post(
      "insert/update-master-carton",
      data: {
        "update_id": updateId ?? "",
        "size": size ?? "",
        "party_name": partyName ?? "",
        "total_carton_per_case": totalCartonPerCase ?? "",
        "carton_status": cartonStatus ?? "",
        "carton_type": cartonType ?? "",
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

  ////////////////////////////////////////////////////////////
  /// DELETE CARTON
  ////////////////////////////////////////////////////////////

  deleteCartonEntry({int? cartonId}) async {
    final response = await dio.post(
      "insert/delete-master-carton",
      data: {"carton_id": cartonId ?? ""},
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

  ////////////////////////////////////////////////////////////
  /// MONO CARTON
  ////////////////////////////////////////////////////////////

  createMonoCartonEntry({
    int? size,
    partyName,
    int? totalMonoCartonPerCase,
    monoCartonStatus,
    monoCartonType,
  }) async {
    final response = await dio.post(
      "insert/master-mono-carton",
      data: {
        "size": size ?? "",
        "party_name": partyName ?? "",
        "total_mono_carton_per_case": totalMonoCartonPerCase ?? "",
        "mono_carton_status": monoCartonStatus ?? "",
        "mono_carton_type": monoCartonType ?? "",
      },
    );

    if (response.statusCode == 200 &&
        response.data["Response"]["Status"]["StatusCode"] == "0") {
      return response.data["Response"]["Status"]["DisplayText"];
    } else {
      throw response.data["Response"]["Status"]["DisplayText"];
    }
  }

  updateMonoCartonEntry({
    int? updateId,
    int? size,
    partyName,
    int? totalMonoCartonPerCase,
    monoCartonStatus,
    monoCartonType,
  }) async {
    final response = await dio.post(
      "insert/update-master-mono-carton",
      data: {
        "update_id": updateId ?? "",
        "size": size ?? "",
        "party_name": partyName ?? "",
        "total_mono_carton_per_case": totalMonoCartonPerCase ?? "",
        "mono_carton_status": monoCartonStatus ?? "",
        "mono_carton_type": monoCartonType ?? "",
      },
    );

    if (response.statusCode == 200 &&
        response.data["Response"]["Status"]["StatusCode"] == "0") {
      return response.data["Response"]["Status"]["DisplayText"];
    } else {
      throw response.data["Response"]["Status"]["DisplayText"];
    }
  }

  deleteMonoCartonEntry({int? monoCartonId}) async {
    final response = await dio.post(
      "insert/delete-master-mono-carton",
      data: {"mono_carton_id": monoCartonId ?? ""},
    );

    if (response.statusCode == 200 &&
        response.data["Response"]["Status"]["StatusCode"] == "0") {
      return response.data["Response"]["Status"]["DisplayText"];
    } else {
      throw response.data["Response"]["Status"]["DisplayText"];
    }
  }
}
