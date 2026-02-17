import 'package:inventory_management_admin_pannel/features/dashboard/bloc/blocsummary/summary_dashboard_bloc.dart';
import 'package:inventory_management_admin_pannel/features/dashboard/bloc/blocsummary/summary_dashboard_event.dart';
import 'package:inventory_management_admin_pannel/features/dashboard/widgets/case_chart.dart';
import 'package:inventory_management_admin_pannel/features/dashboard/widgets/dashboard_table.dart';
import 'package:inventory_management_admin_pannel/features/dashboard/widgets/summary_card_row.dart';
import 'package:inventory_management_admin_pannel/features/dashboard/widgets/summary_complete.dart';
import 'package:inventory_management_admin_pannel/features/master_api/box_size/bloc/box_size_bloc.dart';
import 'package:inventory_management_admin_pannel/features/master_api/box_size/bloc/box_size_event.dart';
import 'package:inventory_management_admin_pannel/features/master_api/repositories/masterrepo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_management_admin_pannel/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:inventory_management_admin_pannel/features/dashboard/bloc/dashboard_event.dart';
import 'package:inventory_management_admin_pannel/features/dashboard/bloc/dashboard_state.dart';
import 'package:inventory_management_admin_pannel/features/dashboard/repository/dashboard_repo.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Placeholder());
  }
}
