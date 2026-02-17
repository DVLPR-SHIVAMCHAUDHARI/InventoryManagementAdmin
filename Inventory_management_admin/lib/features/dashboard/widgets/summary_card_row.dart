import 'package:inventory_management_admin_pannel/features/dashboard/models/stage_summary_model.dart';
import 'package:inventory_management_admin_pannel/features/dashboard/utils/utils.dart';
import 'package:flutter/material.dart';

class SummaryCardsRow extends StatelessWidget {
  final StageSummaryModel data;

  const SummaryCardsRow({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final items = [
      ("Total Boxes", data.totalBoxes, Colors.blue, ""),
      ("Renuka Warehouses", data.stage1, Colors.orange, "Stored"),
      ("Renuka → Faridabad", data.stage1To2, Colors.purple, "In-transit"),
      ("Faridabad Warehouse", data.stage2, Colors.green, "Stored"),
      ("Faridabad → Renuka", data.stage2To1, Colors.red, "In-transit"),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5, // 👈 PERFECT FOR WEB
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 2.5,
      ),
      itemCount: items.length,
      itemBuilder: (_, i) {
        final e = items[i];
        return dashcard(
          color: e.$3,
          text: e.$1,
          count: e.$2.toString(),
          condition: e.$4,
        );
      },
    );
  }
}
