import 'package:inventory_mobile_app/core/services/dio_repo.dart';
import 'package:inventory_mobile_app/features/master/master_model/bottle_combination_model.dart';
import 'package:inventory_mobile_app/features/master/master_model/mapping_bottle_model.dart';
import 'package:inventory_mobile_app/features/master/master_model/mapping_label_model.dart';

class MasterRepo extends Repository {
  Future<List> getBottleList() async {
    final response = await dio.get("insert/get-master-bottle");

    final responseData = response.data["Response"];
    final status = responseData["Status"];

    if (response.statusCode == 200 && status["StatusCode"] == "0") {
      final List dataList = responseData["ResponseData"]["data"] ?? [];

      return dataList;
    } else {
      throw status["DisplayText"] ?? "Failed to fetch bottle list";
    }
  }

  Future<List> getCapList() async {
    final response = await dio.get("insert/get-master-cap");

    final root = response.data;
    final responseNode = root["Response"];
    final status = responseNode?["Status"];

    if (response.statusCode == 200 && status?["StatusCode"] == "0") {
      final List data = responseNode?["ResponseData"]?["data"] ?? [];

      return data;
    } else {
      throw status?["DisplayText"] ?? "Failed to fetch cap list";
    }
  }

  Future<List> getlabellist() async {
    final response = await dio.get("insert/get-master-lable");

    final root = response.data;
    final responseNode = root["Response"];
    final status = responseNode?["Status"];

    if (response.statusCode == 200 && status?["StatusCode"] == "0") {
      final List data = responseNode?["ResponseData"]?["data"] ?? [];

      return data;
    } else {
      throw status?["DisplayText"] ?? "Failed to fetch label list";
    }
  }

  Future<List> getcartonlist() async {
    final response = await dio.get("insert/get-master-carton");

    final root = response.data;
    final responseNode = root["Response"];
    final status = responseNode?["Status"];

    if (response.statusCode == 200 && status?["StatusCode"] == "0") {
      final List data = responseNode?["ResponseData"]?["data"] ?? [];

      return data;
    } else {
      throw status?["DisplayText"] ?? "Failed to fetch carton list";
    }
  }

  Future<List> getmonocartonlist() async {
    final response = await dio.get("insert/get-master-mono-carton");

    final root = response.data;
    final responseNode = root["Response"];
    final status = responseNode?["Status"];

    if (response.statusCode == 200 && status?["StatusCode"] == "0") {
      final List data = responseNode?["ResponseData"]?["data"] ?? [];

      return data;
    } else {
      throw status?["DisplayText"] ?? "Failed to fetch monocarton list";
    }
  }

  Future fetchParties() async {
    try {
      final response = await dio.get("common/get-party");

      final responseBody = response.data["Response"];
      final status = responseBody["Status"];

      if (status["StatusCode"] != "0") {
        throw status["DisplayText"] ?? "Failed to fetch parties";
      }

      final responseData = responseBody["ResponseData"];

      return responseData["mst_party"];
    } catch (e) {
      throw e.toString();
    }
  }

  Future fetchBrands() async {
    try {
      final response = await dio.get("common/get-brand");

      final responseBody = response.data["Response"];
      final status = responseBody["Status"];

      if (status["StatusCode"] != "0") {
        throw status["DisplayText"] ?? "Failed to fetch brands";
      }

      final responseData = responseBody["ResponseData"];

      return responseData["mst_brand"];
    } catch (e) {
      throw e.toString();
    }
  }

  Future fetchBottleSizes() async {
    try {
      final response = await dio.get("common/get-bottle-size");

      final responseBody = response.data["Response"];
      final status = responseBody["Status"];

      if (status["StatusCode"] != "0") {
        throw status["DisplayText"] ?? "Failed to fetch bottle sizes";
      }

      final responseData = responseBody["ResponseData"];

      return responseData["mst_bottle_size"];
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<BottleCombinationModel>> fetchCombinationBottle() async {
    try {
      final response = await dio.get("common/get-combination-bottle");

      final responseBody = response.data["Response"];
      final status = responseBody["Status"];

      if (status["StatusCode"] != "0") {
        throw status["DisplayText"] ?? "Failed to fetch combination bottle";
      }

      final responseData = responseBody["ResponseData"];

      return (responseData["combination_bottle"] as List)
          .map((e) => BottleCombinationModel.fromJson(e))
          .toList();
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<MappingBottleModel>> fetchMappingBottle({
    int? brandNameId,
    int? bottleSizeId,
  }) async {
    try {
      final response = await dio.get(
        "common/get-mapping-bottle",
        queryParameters: {
          "brand_name_id": brandNameId ?? "",
          "bottle_size_id": bottleSizeId ?? "",
        },
      );

      final responseBody = response.data["Response"];
      final status = responseBody["Status"];

      if (status["StatusCode"] != "0") {
        throw status["DisplayText"] ?? "Failed to fetch mapping bottle";
      }

      final responseData = responseBody["ResponseData"];

      final list = responseData["mapping_bottle"] as List;

      return list.map((e) => MappingBottleModel.fromJson(e)).toList();
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<MappingLabelModel>> fetchMappingLabel({
    int? brandNameId,
    int? bottleSizeId,
    int? labelTypeId,
  }) async {
    try {
      final response = await dio.get(
        "common/get-mapping-label",
        queryParameters: {
          "brand_name_id": brandNameId ?? "",
          "bottle_size_id": bottleSizeId ?? "",
          "label_type_id": labelTypeId ?? "",
        },
      );

      final responseBody = response.data["Response"];
      final status = responseBody["Status"];

      if (status["StatusCode"] != "0") {
        throw status["DisplayText"] ?? "Failed to fetch mapping label";
      }

      final responseData = responseBody["ResponseData"];

      final list = responseData["mapping_label"] as List;

      return list.map((e) => MappingLabelModel.fromJson(e)).toList();
    } catch (e) {
      throw e.toString();
    }
  }
}
