import 'package:inventory_management_admin_pannel/features/dashboard/models/barcode_model.dart';
import 'package:inventory_management_admin_pannel/features/dashboard/models/history_model.dart';
import 'package:inventory_management_admin_pannel/features/dashboard/models/stage_summary_model.dart';

import 'package:inventory_management_admin_pannel/features/dashboard/models/table_location_model.dart';
import 'package:dio/dio.dart';
import 'package:inventory_management_admin_pannel/core/Utils/repository.dart';

class DashboardRepo extends Repository {
  DashboardRepo() : super();

  /// ===============================
  /// GET CURRENT LOCATIONS (STAGES)
  /// ===============================
  Future<List<CurrentLocationModel>> fetchCurrentLocations() async {
    final response = await dio.get("/super-admin/get-current-location");

    final responseBody = response.data["Response"];
    final status = responseBody["Status"];

    if (status["StatusCode"] != "0") {
      throw status["DisplayText"] ?? "Failed to fetch current locations";
    }

    final List list =
        responseBody["ResponseData"]["mst_current_location"] ?? [];

    return list.map((e) => CurrentLocationModel.fromJson(e)).toList();
  }

  /// ===============================
  /// GET BARCODE LIST (DASHBOARD TABLE)
  /// ===============================
  Future<Map<String, dynamic>> fetchBarcodes({
    int? currentLocation,
    String barcode = "",
    String boxSize = "",
    String sortBy = "id",
    String orderBy = "asc",
    int offset = 1,
    int limit = 10,
  }) async {
    final response = await dio.get(
      "/super-admin/get-list-barcode",
      queryParameters: {
        "current_location": currentLocation,
        "barcode": barcode,
        "box_size": boxSize,
        "sort_by": sortBy,
        "order_by": orderBy,
        "offset": offset,
        "limit": limit,
      },
    );

    final responseBody = response.data["Response"];
    final status = responseBody["Status"];

    if (status["StatusCode"] != "0") {
      throw status["DisplayText"] ?? "Failed to fetch barcodes";
    }

    final responseData = responseBody["ResponseData"];

    final List list = responseData["list"] ?? [];
    final int count = responseData["count"] ?? 0;

    return {
      "list": list.map((e) => BarcodeModel.fromJson(e)).toList(),
      "count": count,
    };
  }

  Future<DashboardSummaryResponse> fetchDashboardSummary({
    required int currentLocation,
    String barcode = '',
    String boxSize = '',
    String sortBy = 'id',
    String orderBy = 'asc',
    int offset = 1,
    int limit = 10,
  }) async {
    final response = await dio.get(
      "/super-admin/dashboard",
      queryParameters: {
        "current_location": currentLocation,
        "barcode": barcode,
        "box_size": boxSize,
        "sort_by": sortBy,
        "order_by": orderBy,
        "offset": offset,
        "limit": limit,
      },
    );

    final body = response.data["Response"];
    final status = body["Status"];

    if (status["StatusCode"] != "0") {
      throw status["DisplayText"] ?? "Dashboard summary failed";
    }

    final data = body["ResponseData"];

    final stage = StageSummaryModel.fromJson(
      data["current_location"]["list"][0],
    );

    final warehouses = (data["main_location"]["list"] as List)
        .map((e) => MainLocationSummaryModel.fromJson(e))
        .toList();

    final parties = (data["party_details"]["list"] as List)
        .map((e) => PartySummaryModel.fromJson(e))
        .toList();

    return DashboardSummaryResponse(
      stageSummary: stage,
      warehouses: warehouses,
      parties: parties,
    );
  }

  /// ===============================
  /// GET BARCODE HISTORY
  /// ===============================
  Future<List<HistoryModel>> fetchBarcodeHistory(int barcodeId) async {
    final response = await dio.get(
      "/super-admin/get-barcode-history/$barcodeId",
    );

    final responseBody = response.data["Response"];
    final status = responseBody["Status"];

    if (status["StatusCode"] != "0") {
      throw status["DisplayText"] ?? "Failed to fetch barcode history";
    }

    final List list = responseBody["ResponseData"]?["Data"] ?? [];

    return list.map((e) => HistoryModel.fromJson(e)).toList();
  }
}

class DashboardSummaryResponse {
  final StageSummaryModel stageSummary;
  final List<MainLocationSummaryModel> warehouses;
  final List<PartySummaryModel> parties;

  DashboardSummaryResponse({
    required this.stageSummary,
    required this.warehouses,
    required this.parties,
  });
}
