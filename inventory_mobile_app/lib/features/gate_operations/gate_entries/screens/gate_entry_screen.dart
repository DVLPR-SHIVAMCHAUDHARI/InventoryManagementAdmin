import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_mobile_app/core/consts/appcolors.dart';
import 'package:inventory_mobile_app/features/gate_operations/gate_entries/bloc/gate_entry_bloc.dart';
import 'package:inventory_mobile_app/features/gate_operations/gate_entries/screens/new_gate_entry_screen.dart';
import 'package:inventory_mobile_app/features/gate_operations/gate_entries/screens/past_entries_screen.dart';
import 'package:inventory_mobile_app/features/gate_operations/gate_exits/bloc/gate_exit_bloc.dart';

import 'package:inventory_mobile_app/features/master/bloc/master_bloc.dart';
import 'package:inventory_mobile_app/features/master/bloc/master_event.dart';

class GateEntryScreen extends StatelessWidget {
  const GateEntryScreen({super.key});

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
            'Gate Entries',
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
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Tab(text: 'Gate IN'),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Tab(text: 'Past Entries'),
                  ),
                ],
              ),
            ),
          ),
        ),

        body: BlocProvider(
          create: (context) => GateEntryBloc(),
          child: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              BlocProvider(
                create: (context) => MasterBloc()..add(FetchParties()),
                child: NewGateEntryPage(),
              ),

              BlocProvider(
                create: (context) => GateExitBloc(),

                child: PastEntriesPage(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
