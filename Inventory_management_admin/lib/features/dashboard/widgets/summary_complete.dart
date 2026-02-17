import 'package:inventory_management_admin_pannel/features/dashboard/bloc/blocsummary/summary_dashboard_bloc.dart';
import 'package:inventory_management_admin_pannel/features/dashboard/bloc/blocsummary/summary_dashboard_state.dart';

import 'package:inventory_management_admin_pannel/features/dashboard/widgets/party_details_chart.dart';
import 'package:inventory_management_admin_pannel/features/dashboard/widgets/pie_chart.dart';

import 'package:inventory_management_admin_pannel/features/dashboard/widgets/summary_card_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardSummarySection extends StatelessWidget {
  const DashboardSummarySection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardSummaryBloc, DashboardSummaryState>(
      builder: (context, state) {
        if (state is DashboardSummaryLoading) {
          return const Padding(
            padding: EdgeInsets.all(40),
            child: CircularProgressIndicator(),
          );
        }

        if (state is DashboardSummaryLoaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// SUMMARY CARDS
              Container(
                clipBehavior: Clip.none,
                child: SummaryCardsRow(data: state.stageSummary),
              ),

              const SizedBox(height: 24),

              /// CHARTS ROW
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 500,
                      child: WarehousePieChart(data: state.warehouses),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: SizedBox(
                      height: 500,
                      child: LocationBoxSizeChart(locations: state.warehouses),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              /// CHARTS ROW
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 500,
                      child: PartyBoxSizeChart(parties: state.parties),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: SizedBox(
                      height: 500,
                      child: PartyPieChart(data: state.parties),
                    ),
                  ),
                ],
              ),
            ],
          );
        }

        if (state is DashboardSummaryError) {
          return Text(state.message);
        }

        return const SizedBox();
      },
    );
  }
}
