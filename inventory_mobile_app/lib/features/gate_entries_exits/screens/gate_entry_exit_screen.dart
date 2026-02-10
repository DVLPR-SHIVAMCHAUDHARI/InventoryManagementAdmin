import 'package:flutter/material.dart';
import 'package:inventory_mobile_app/core/consts/appcolors.dart';
import 'package:inventory_mobile_app/features/gate_entries_exits/gate_entry/screens/gate_entry_screen.dart'
    hide Dimens;
import 'package:inventory_mobile_app/features/gate_entries_exits/gate_exit/screens/gate_exit_screen.dart';

class GateOperationsPage extends StatelessWidget {
  const GateOperationsPage({super.key});

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
            'Gate Operations',
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
                  Tab(text: 'Gate IN'),
                  Tab(text: 'Gate OUT'),
                ],
              ),
            ),
          ),
        ),

        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [GateEntryPage(), GateExitPage()],
        ),
      ),
    );
  }
}
