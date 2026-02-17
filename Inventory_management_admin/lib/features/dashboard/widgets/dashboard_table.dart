import 'package:inventory_management_admin_pannel/core/Utils/globals.dart';
import 'package:inventory_management_admin_pannel/core/widgets/appdropdown.dart';
import 'package:inventory_management_admin_pannel/features/dashboard/widgets/history_view.dart';
import 'package:inventory_management_admin_pannel/features/master_api/box_size/bloc/box_size_bloc.dart';
import 'package:inventory_management_admin_pannel/features/master_api/box_size/bloc/box_size_state.dart';
import 'package:inventory_management_admin_pannel/features/master_api/models/box_size_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:inventory_management_admin_pannel/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:inventory_management_admin_pannel/features/dashboard/bloc/dashboard_event.dart';
import 'package:inventory_management_admin_pannel/features/dashboard/bloc/dashboard_state.dart';

class DashboardTableSection extends StatefulWidget {
  final DashboardLoaded state;

  const DashboardTableSection({super.key, required this.state});

  @override
  State<DashboardTableSection> createState() => _DashboardTableSectionState();
}

class _DashboardTableSectionState extends State<DashboardTableSection> {
  final TextEditingController barcodeCtrl = TextEditingController();
  BoxSizeModel? _selectedBoxSize;
  final TextEditingController boxSizeCtrl = TextEditingController();
  final Set<String> _expandedRows = {};

  @override
  void dispose() {
    barcodeCtrl.dispose();
    boxSizeCtrl.dispose();
    super.dispose();
  }

  String _fmt(DateTime? d) =>
      d == null ? "-" : DateFormat('dd MMM yyyy, hh:mm a').format(d);

  @override
  Widget build(BuildContext context) {
    final state = widget.state;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Cases",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 12),

          /// 🔍 FILTERS (ALL HERE)
          Row(
            children: [
              DropdownButton<int>(
                value:
                    state.selectedLocation != null &&
                        state.selectedLocation != 0
                    ? state.selectedLocation
                    : null, // show hint when null or 0
                hint: const Text("All Locations"),
                items: [
                  ...state.locations.map(
                    (e) => DropdownMenuItem<int>(
                      value: e.id,
                      child: Text(e.location),
                    ),
                  ),
                ],
                onChanged: (v) {
                  context.read<DashboardBloc>().add(
                    ChangeLocationEvent(
                      v ?? 0,
                    ), // backend still uses 0 for “all”
                  );
                },
              ),

              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  controller: barcodeCtrl,
                  decoration: const InputDecoration(
                    hintText: "Barcode",
                    isDense: true,
                  ),
                ),
              ),
              const SizedBox(width: 12),

              Expanded(
                child: BlocBuilder<BoxSizeBloc, BoxSizeState>(
                  builder: (context, state) {
                    if (state is BoxSizeLoading) {
                      return NoDropdownShimmer();
                    }

                    if (state is BoxSizeLoaded) {
                      return NoLabelDropdown<BoxSizeModel>(
                        hint: "Choose Box Size",
                        items: state.sizes,
                        value: _selectedBoxSize,
                        itemLabel: (b) => "${b.length}X${b.width}X${b.height}",
                        onChanged: (value) {
                          setState(() => _selectedBoxSize = value);
                        },
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                onPressed: () {
                  String boxsize =
                      "${_selectedBoxSize!.length.toString()}X${_selectedBoxSize!.width.toString()}X${_selectedBoxSize!.height.toString()}";
                  context.read<DashboardBloc>().add(
                    ApplyFilterEvent(
                      barcode: barcodeCtrl.text.trim(),
                      boxSize: boxsize,
                    ),
                  );
                },
                child: const Text("Apply"),
              ),
            ],
          ),

          const SizedBox(height: 16),
          const SizedBox(height: 16),

          /// 📋 TABLE HEADER
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                _cell("Barcode", flex: 2, bold: true),
                _cell("Box Size", bold: true),
                _cell("Location", flex: 2, bold: true),
                _cell("Created By", bold: true),
                _cell("Updated By", bold: true),
                _cell("Created At", flex: 2, bold: true),
                _cell("Updated At", flex: 2, bold: true),
              ],
            ),
          ),

          const SizedBox(height: 4),

          /// 📋 TABLE BODY
          Expanded(
            child: ListView.separated(
              itemCount: state.barcodes.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (_, i) {
                final b = state.barcodes[i];
                final isExpanded = _expandedRows.contains(b.barcode);

                return Material(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        if (isExpanded) {
                          _expandedRows.remove(b.barcode);
                        } else {
                          _expandedRows.add(b.barcode);

                          context.read<DashboardBloc>().add(
                            LoadBarcodeHistory(b.id),
                          );
                        }
                      });
                    },

                    child: Column(
                      children: [
                        // Main row
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade200),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              _cell(b.barcode, flex: 2, bold: true),
                              _cell(b.boxSize),
                              _cell(b.currentLocationDetail, flex: 2),
                              _cell(b.createdBy),
                              _cell(b.updatedBy.isEmpty ? "-" : b.updatedBy),
                              _cell(_fmt(b.createdAt), flex: 2),
                              _cell(_fmt(b.updatedAt), flex: 2),
                            ],
                          ),
                        ),

                        // Expanded content
                        if (isExpanded) ...[
                          const SizedBox(height: 8),

                          Builder(
                            builder: (context) {
                              final dashboardState =
                                  context.watch<DashboardBloc>().state
                                      as DashboardLoaded;

                              final history = dashboardState
                                  .historyMap[b.id]; // ← key point

                              if (dashboardState.historyLoading &&
                                  history == null) {
                                return const Padding(
                                  padding: EdgeInsets.all(12),
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              }

                              if (dashboardState.historyError != null &&
                                  history == null) {
                                return Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Text(
                                    dashboardState.historyError!,
                                    style: const TextStyle(color: Colors.red),
                                  ),
                                );
                              }

                              if (history != null && history.isEmpty) {
                                return const Padding(
                                  padding: EdgeInsets.all(12),
                                  child: Center(
                                    child: Text(
                                      "No history available for this barcode",
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.black54,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ),
                                );
                              }

                              if (history != null && history.isNotEmpty) {
                                return HistoryView(history: history);
                              }

                              return const SizedBox.shrink();
                            },
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          /// 📋 TABLE
          const SizedBox(height: 12),

          /// 📄 PAGINATION
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "Page ${state.currentPage} of "
                "${(state.totalCount / 10).ceil().clamp(1, 999)}",
              ),
              IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: state.currentPage > 1
                    ? () => context.read<DashboardBloc>().add(
                        ChangePageEvent(state.currentPage - 1),
                      )
                    : null,
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: state.currentPage < (state.totalCount / 10).ceil()
                    ? () => context.read<DashboardBloc>().add(
                        ChangePageEvent(state.currentPage + 1),
                      )
                    : null,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _cell(String text, {int flex = 1, bool bold = false}) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 13,
          fontWeight: bold ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
    );
  }
}
