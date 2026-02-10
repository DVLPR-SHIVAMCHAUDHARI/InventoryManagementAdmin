import 'package:flutter/material.dart';
import 'package:inventory_mobile_app/core/consts/appcolors.dart';
import 'package:inventory_mobile_app/features/weight_bridge/screens/weight_bridge_entry_screen.dart';
import 'package:inventory_mobile_app/features/weight_bridge/screens/weignt_bridge_entry_list.dart';

class WeightBridgeScreen extends StatelessWidget {
  const WeightBridgeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          leading: BackButton(color: Colors.white),
          toolbarHeight: 60, // ✅ FIXED height
          backgroundColor: AppColors.primary,
          centerTitle: true,
          title: const Text(
            'Weight Bridge ',
            style: TextStyle(
              fontSize: 16, // ✅ FIXED (NO .sp)
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(40), // ✅ FIXED
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(8),
              ),
              child: TabBar(
                indicator: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                labelColor: Colors.white,
                unselectedLabelColor: AppColors.textSecondary,
                labelStyle: const TextStyle(
                  fontSize: 13, // ✅ FIXED
                  fontWeight: FontWeight.w600,
                ),
                labelPadding: const EdgeInsets.symmetric(horizontal: 8),
                tabs: const [
                  Tab(text: 'Weight Bridge IN'),
                  Tab(text: 'Weight Bridge OUT'),
                ],
              ),
            ),
          ),
        ),

        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [WeighBridgeEntryPage(), WeighBridgeOutListPage()],
        ),
      ),
    );
  }
}
