import 'package:inventory_mobile_app/core/consts/globals.dart';
import 'package:inventory_mobile_app/core/services/dio_repo.dart';
import 'package:inventory_mobile_app/core/services/tokenservice.dart';

class AuthRepo extends Repository {
  Future<Map<String, dynamic>> signin({
    required String email,
    required String password,
  }) async {
    try {
      final response = await dio.post(
        "user/login",
        data: {"email": email, "password": password},
      );

      logger.d("Login API: ${response.data}");

      // Check HTTP status
      if (response.statusCode != 200) {
        return {"success": false, "message": "Server error"};
      }

      final status = response.data["Response"]["Status"]["StatusCode"];
      final msg = response.data["Response"]["Status"]["DisplayText"];

      // API level error
      if (status != "0") {
        return {"success": false, "message": msg};
      }

      // Extract user data
      final data = response.data["Response"]["ResponseData"];

      // Extract token
      final token = data["x_auth_token"];
      if (token != null && token.isNotEmpty) {
        await TokenServices().storeTokens(accessToken: token);
      }

      // Extract user info
      await TokenServices().storeUsername(data["fullname"]);
      await TokenServices().storeUserRoleId(data["role_id"].toString());

      return {
        "success": true,
        "user": {
          "id": data["user_id"],
          "role": data["role_id"],
          "name": data["fullname"],
        },
      };
    } catch (e) {
      logger.e("Login error: $e");
      return {"success": false, "message": "Something went wrong"};
    }
  }
}
