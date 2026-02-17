import 'package:inventory_management_admin_pannel/core/Utils/globals.dart';
import 'package:inventory_management_admin_pannel/core/Utils/repository.dart';

class UserManagementRepo extends Repository {
  /// --------------------- CREATE USER ---------------------
  Future<dynamic> createUser({
    required String fullname,
    required String email,
    required String password,
    required String departmentId,

    required int roleId,
  }) async {
    try {
      final response = await dio.post(
        "user/signup",
        data: {
          "fullname": fullname,
          "email": email,
          "password": password,
          "department_id": departmentId,

          "role_id": roleId,
        },
      );

      logger.i("Signup Response: ${response.data}");

      if (response.statusCode == 200) {
        final status = response.data["Response"]?["Status"]?["StatusCode"];

        if (status == "0") {
          return response.data["Response"]?["ResponseData"];
        } else {
          final errorText =
              response.data["Response"]?["Status"]?["DisplayText"] ??
              "Signup failed";
          return Future.error(errorText);
        }
      } else {
        return Future.error(
          "Server error: ${response.statusCode} ${response.statusMessage}",
        );
      }
    } catch (e) {
      logger.e("Signup Error: $e");
      return Future.error("Something went wrong: $e");
    }
  }

  ///-----------------------Delete User-----------------------------
  ///

  deleteUser({required id}) async {
    try {
      final response = await dio.post(
        "user/delete",
        data: {"delete_user_id": id},
      );
      logger.i("delete Response: ${response.data}");
      if (response.statusCode == 200) {
        final status = response.data["Response"]["Status"]["StatusCode"];

        if (status == "0") {
          return "User Deleted Successfully";
        } else {
          final errorText =
              response.data["Response"]["Status"]["DisplayText"] ??
              "Delete failed";
          return Future.error(errorText);
        }
      } else {
        return Future.error("Server error: ${response.statusMessage}");
      }
    } catch (e) {
      logger.e("Delete Error: $e");
      return Future.error("Something went wrong: $e");
    }
  }

  ///-----------------------Update User-----------------------------
  ///

  Future<dynamic> updateUser({
    required String fullname,
    required String email,
    required int id,
    required int departmentId,

    required int roleId,
  }) async {
    try {
      final response = await dio.post(
        "user/update",
        data: {
          "fullname": fullname,
          "email": email,
          "department_id": departmentId,

          "role_id": roleId,
          "id": id,
        },
      );

      logger.i("Update Response: ${response.data}");

      if (response.statusCode == 200) {
        final status = response.data["Response"]?["Status"]?["StatusCode"];

        if (status == "0") {
          return "User Updated Successfully";
        } else {
          final errorText =
              response.data["Response"]?["Status"]?["DisplayText"] ??
              "Update failed";
          return Future.error(errorText);
        }
      } else {
        return Future.error(
          "Server error: ${response.statusCode} ${response.statusMessage}",
        );
      }
    } catch (e) {
      logger.e("Update Error: $e");
      return Future.error("Something went wrong: $e");
    }
  }

  ///-----------------------Update Password-----------------------------
  ///

  updatePassword({required pass, id}) async {
    try {
      final response = await dio.post(
        "user/update-password",
        data: {"password": pass, "updated_user_id": id},
      );
      logger.i("delete Response: ${response.data}");
      if (response.statusCode == 200) {
        final status = response.data["Response"]["Status"]["StatusCode"];

        if (status == "0") {
          return "Password Updated Successfully";
        } else {
          final errorText =
              response.data["Response"]["Status"]["DisplayText"] ??
              "Update failed";
          return Future.error(errorText);
        }
      } else {
        return Future.error("Server error: ${response.statusMessage}");
      }
    } catch (e) {
      logger.e("Update Error: $e");
      return Future.error("Something went wrong: $e");
    }
  }

  ///-----------------------Verify User-----------------------------
  ///

  verifyUser({required id}) async {
    try {
      final response = await dio.post(
        "user/verify",
        data: {"verify_user_id": id},
      );
      logger.i("Verify Response: ${response.data}");
      if (response.statusCode == 200) {
        final status = response.data["Response"]["Status"]["StatusCode"];

        if (status == "0") {
          return "User Verified Successfully";
        } else {
          final errorText =
              response.data["Response"]["Status"]["DisplayText"] ??
              "Verification failed";
          return Future.error(errorText);
        }
      } else {
        return Future.error("Server error: ${response.statusMessage}");
      }
    } catch (e) {
      logger.e("Verification Error: $e");
      return Future.error("Something went wrong: $e");
    }
  }

  ///-----------------------Verify User-----------------------------
  ///

  unverifyUser({required id}) async {
    try {
      final response = await dio.post(
        "user/unverified",
        data: {"unverified_user_id": id},
      );
      logger.i("unVerify Response: ${response.data}");
      if (response.statusCode == 200) {
        final status = response.data["Response"]["Status"]["StatusCode"];

        if (status == "0") {
          return "User unVerified Successfully";
        } else {
          final errorText =
              response.data["Response"]["Status"]["DisplayText"] ??
              "Verification failed";
          return Future.error(errorText);
        }
      } else {
        return Future.error("Server error: ${response.statusMessage}");
      }
    } catch (e) {
      logger.e("Verification Error: $e");
      return Future.error("Something went wrong: $e");
    }
  }

  ///-----------------------User List-----------------------------
  ///

  Future<dynamic> getUserList({
    String email = "",
    String fullname = "",
    String sortBy = "id",
    String orderBy = "asc",
    int offset = 1,
    int limit = 10,
  }) async {
    try {
      final response = await dio.get(
        "user/user-list",
        queryParameters: {
          "email": email,
          "fullname": fullname,
          "sort_by": sortBy,
          "order_by": orderBy,
          "offset": offset,
          "limit": limit,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data["Response"]["ResponseData"];

        if (data["error"] == false) {
          return data; // contains list + count
        } else {
          return data["code"]; // error code
        }
      } else {
        return response.statusMessage;
      }
    } catch (e) {
      logger.e(e);
      return null;
    }
  }
}
