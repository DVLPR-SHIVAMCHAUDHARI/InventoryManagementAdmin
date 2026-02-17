import 'package:inventory_management_admin_pannel/core/Utils/globals.dart';
import 'package:inventory_management_admin_pannel/core/Utils/repository.dart';
import 'package:inventory_management_admin_pannel/features/master_api/models/box_size_model.dart';
import 'package:inventory_management_admin_pannel/features/master_api/models/department_model.dart';
import 'package:inventory_management_admin_pannel/features/master_api/models/party_model.dart';
import 'package:inventory_management_admin_pannel/features/master_api/models/stage_model.dart';

class MasterRepo extends Repository {
  Future<List<DepartmentModel>> fetchDepartments() async {
    final response = await dio.get("/common/get-department");

    final responseBody = response.data["Response"];
    final status = responseBody["Status"];

    if (status["StatusCode"] != "0") {
      throw status["DisplayText"] ?? "Failed to fetch departments";
    }

    final List list = responseBody["ResponseData"]["mst_department"] as List;

    return list
        .map((e) => DepartmentModel.fromJson(e))
        .where((d) => !d.isDeleted)
        .toList();
  }

  Future<List<BoxSizeModel>> fetchBoxSizes() async {
    final response = await dio.get("/super-admin/get-size");

    final responseBody = response.data["Response"];
    final status = responseBody["Status"];

    if (status["StatusCode"] != "0") {
      throw status["DisplayText"] ?? "Failed to fetch box sizes";
    }

    final List list = responseBody["ResponseData"]["mst_box_size"] as List;

    return list
        .map((e) => BoxSizeModel.fromJson(e))
        .where((b) => !b.isDeleted)
        .toList();
  }

  Future<void> createBoxSize({
    required int length,
    required int height,
    required int width,
  }) async {
    final response = await dio.post(
      "/super-admin/create-size",
      data: {"length": length, "height": height, "width": width},
    );

    final responseBody = response.data["Response"];
    final status = responseBody["Status"];

    if (status["StatusCode"] != "0") {
      throw status["DisplayText"] ?? "Failed to create box size";
    }
  }

  Future<void> updateBoxSize({
    required int id,
    required int length,
    required int height,
    required int width,
  }) async {
    final response = await dio.post(
      "/super-admin/update-size",
      data: {"box_id": id, "length": length, "height": height, "width": width},
    );

    final responseBody = response.data["Response"];
    final status = responseBody["Status"];

    if (status["StatusCode"] != "0") {
      throw status["DisplayText"] ?? "Failed to update box size";
    }
  }

  Future<void> deleteBoxSize({required int id}) async {
    final response = await dio.post(
      "/super-admin/delete-size",
      data: {"box_id": id},
    );

    final responseBody = response.data["Response"];
    final status = responseBody["Status"];

    if (status["StatusCode"] != "0") {
      throw status["DisplayText"] ?? "Failed to delete box size";
    }
  }

  Future<List<StageModel>> fetchStages() async {
    final response = await dio.get("/super-admin/get-stage");

    final responseBody = response.data["Response"];
    final status = responseBody["Status"];

    if (status["StatusCode"] != "0") {
      throw status["DisplayText"] ?? "Failed to fetch stages";
    }

    final List list = responseBody["ResponseData"]["mst_stage"] as List;

    return list.map((e) => StageModel.fromJson(e)).toList();
  }

  Future<void> createStage({required String stage}) async {
    final response = await dio.post(
      "/super-admin/create-stage",
      data: {"stage": stage},
    );

    final responseBody = response.data["Response"];
    final status = responseBody["Status"];

    if (status["StatusCode"] != "0") {
      throw status["DisplayText"] ?? "Failed to create stage";
    }
  }

  Future<void> updateStage({required int id, required String stage}) async {
    final response = await dio.post(
      "/super-admin/update-stage",
      data: {"id": id, "stage": stage},
    );

    final responseBody = response.data["Response"];
    final status = responseBody["Status"];

    if (status["StatusCode"] != "0") {
      throw status["DisplayText"] ?? "Failed to update stage";
    }
  }

  Future<void> deleteStage({required int id}) async {
    final response = await dio.post(
      "/super-admin/delete-stage",
      data: {"id": id},
    );

    final responseBody = response.data["Response"];
    final status = responseBody["Status"];

    if (status["StatusCode"] != "0") {
      throw status["DisplayText"] ?? "Failed to delete stage";
    }
  }

  Future<List<PartyModel>> fetchParties() async {
    final response = await dio.get("/super-admin/get-party");

    final responseBody = response.data["Response"];
    final status = responseBody["Status"];

    if (status["StatusCode"] != "0") {
      throw status["DisplayText"] ?? "Failed to fetch parties";
    }

    final responseData = responseBody["ResponseData"];

    final List list = (responseData["mst_box_party"] as List?) ?? [];

    return list.map((e) => PartyModel.fromJson(e)).toList();
  }

  Future<void> createParty({
    required String partyName,
    required String companyAddress,
    required int departmentLocation,
  }) async {
    final response = await dio.post(
      "/super-admin/create-party",
      data: {
        "party_name": partyName,
        "company_address": companyAddress,
        "department_location": departmentLocation,
      },
    );

    final responseBody = response.data["Response"];
    final status = responseBody["Status"];

    if (status["StatusCode"] != "0") {
      throw status["DisplayText"] ?? "Failed to create party";
    }
  }

  Future<void> updateParty({
    required int id,
    required String partyName,
    required String companyAddress,
    required int boxLocation,
  }) async {
    final response = await dio.post(
      "/super-admin/update-party",
      data: {
        "id": id,
        "party_name": partyName,
        "company_address": companyAddress,
        "department_location": boxLocation,
      },
    );

    final responseBody = response.data["Response"];
    final status = responseBody["Status"];

    if (status["StatusCode"] != "0") {
      throw status["DisplayText"] ?? "Failed to update party";
    }
  }

  Future<void> deleteParty({required int id}) async {
    final response = await dio.post(
      "/super-admin/delete-party",
      data: {"id": id},
    );

    final responseBody = response.data["Response"];
    final status = responseBody["Status"];

    if (status["StatusCode"] != "0") {
      throw status["DisplayText"] ?? "Failed to delete party";
    }
  }

  Future<dynamic> createDepartment({required String departmentName}) async {
    try {
      final response = await dio.post(
        "/super-admin/create-department",
        data: {"department_name": departmentName},
      );

      logger.i("Create Department Response: ${response.data}");

      if (response.statusCode == 200) {
        final status = response.data["Response"]?["Status"]?["StatusCode"];

        if (status == "0") {
          return response.data["Response"]?["ResponseData"];
        } else {
          final errorText =
              response.data["Response"]?["Status"]?["DisplayText"] ??
              "Create department failed";
          return Future.error(errorText);
        }
      } else {
        return Future.error(
          "Server error: ${response.statusCode} ${response.statusMessage}",
        );
      }
    } catch (e) {
      logger.e("Create Department Error: $e");
      return Future.error("Something went wrong: $e");
    }
  }

  /// =======================
  /// UPDATE DEPARTMENT
  /// =======================
  Future<dynamic> updateDepartment({
    required String departmentId,
    required String departmentName,
  }) async {
    try {
      final response = await dio.post(
        "/super-admin/update-department",
        data: {
          "department_id": departmentId,
          "department_name": departmentName,
        },
      );

      logger.i("Update Department Response: ${response.data}");

      if (response.statusCode == 200) {
        final status = response.data["Response"]?["Status"]?["StatusCode"];

        if (status == "0") {
          return "Department updated successfully";
        } else {
          final errorText =
              response.data["Response"]?["Status"]?["DisplayText"] ??
              "Update department failed";
          return Future.error(errorText);
        }
      } else {
        return Future.error(
          "Server error: ${response.statusCode} ${response.statusMessage}",
        );
      }
    } catch (e) {
      logger.e("Update Department Error: $e");
      return Future.error("Something went wrong: $e");
    }
  }

  /// =======================
  /// DELETE DEPARTMENT
  /// =======================
  Future<dynamic> deleteDepartment({required String departmentId}) async {
    try {
      final response = await dio.post(
        "/super-admin/delete-department",
        data: {"department_id": departmentId},
      );

      logger.i("Delete Department Response: ${response.data}");

      if (response.statusCode == 200) {
        final status = response.data["Response"]?["Status"]?["StatusCode"];

        if (status == "0") {
          return "Department deleted successfully";
        } else {
          final errorText =
              response.data["Response"]?["Status"]?["DisplayText"] ??
              "Delete department failed";
          return Future.error(errorText);
        }
      } else {
        return Future.error(
          "Server error: ${response.statusCode} ${response.statusMessage}",
        );
      }
    } catch (e) {
      logger.e("Delete Department Error: $e");
      return Future.error("Something went wrong: $e");
    }
  }
}
