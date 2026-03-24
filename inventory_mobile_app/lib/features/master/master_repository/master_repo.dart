import 'package:inventory_mobile_app/core/services/dio_repo.dart';

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
}
