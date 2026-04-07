import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:inventory_mobile_app/core/consts/appcolors.dart';
import 'package:inventory_mobile_app/core/consts/snack_bar.dart';
import 'package:inventory_mobile_app/features/gate_operations/gate_entries/bloc/gate_entry_bloc.dart';
import 'package:inventory_mobile_app/features/gate_operations/gate_entries/bloc/gate_entry_event.dart';
import 'package:inventory_mobile_app/features/gate_operations/gate_entries/bloc/gate_entry_state.dart';
import 'package:inventory_mobile_app/features/gate_operations/gate_entries/models/gate_Entry_model.dart';
import 'package:inventory_mobile_app/features/gate_operations/gate_exits/bloc/gate_exit_bloc.dart';
import 'package:inventory_mobile_app/features/gate_operations/gate_exits/bloc/gate_exit_event.dart';
import 'package:inventory_mobile_app/features/gate_operations/gate_exits/bloc/gate_exit_state.dart';
import 'package:inventory_mobile_app/features/gate_operations/gate_exits/model/gate_exit_model.dart';

class GateExitScreen extends StatelessWidget {
  const GateExitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => GateEntryBloc()),
        BlocProvider(create: (_) => GateExitBloc()),
      ],
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            leading: const BackButton(color: Colors.white),
            backgroundColor: AppColors.primary,
            centerTitle: true,
            title: const Text(
              'Gate Exit',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(40),
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
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                  tabs: const [
                    Tab(text: 'Gate Entries'),
                    Tab(text: 'Gate Exits'),
                  ],
                ),
              ),
            ),
          ),
          body: const TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [_GateEntriesTab(), _GateExitsTab()],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────
// TAB 1 — Gate Entries (with Exit button)
// ─────────────────────────────────────────
class _GateEntriesTab extends StatelessWidget {
  const _GateEntriesTab();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
              tabs: const [
                Tab(text: 'Filled Truck'),
                Tab(text: 'Empty Truck'),
              ],
            ),
          ),
          const Expanded(
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                _GateEntryList(truckType: 1),
                _GateEntryList(truckType: 2),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────
// GATE ENTRY LIST WITH DATE PICKER
// ─────────────────────────────────────────
class _GateEntryList extends StatefulWidget {
  final int truckType;
  const _GateEntryList({required this.truckType});

  @override
  State<_GateEntryList> createState() => _GateEntryListState();
}

class _GateEntryListState extends State<_GateEntryList> {
  late String selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    _fetch();
  }

  void _fetch() {
    context.read<GateEntryBloc>().add(
      FetchGateEntries(truckType: widget.truckType, date: selectedDate),
    );
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.tryParse(selectedDate) ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        selectedDate = DateFormat('yyyy-MM-dd').format(picked);
      });
      _fetch();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GateEntryBloc, GateEntryState>(
      listener: (context, state) {
        if (state is GateExitSuccess) {
          snackbar(
            context,
            color: Colors.green,
            title: "Exited",
            message: "Exited successfully",
          );
          _fetch();
        }
        if (state is GateEntryDeleteSuccess) {
          snackbar(
            context,
            color: Colors.green,
            title: "Deleted",
            message: state.message,
          );
          _fetch();
        }
        if (state is GateEntryDeleteFailure) {
          snackbar(
            context,
            color: Colors.red,
            title: "Error",
            message: state.message,
          );
        }
      },
      child: Column(
        children: [
          // ── Date Picker ──
          _DatePickerBar(date: selectedDate, onTap: _pickDate),

          // ── List ──
          Expanded(
            child: BlocBuilder<GateEntryBloc, GateEntryState>(
              builder: (context, state) {
                if (state is GateEntryListLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is GateEntryListFailure) {
                  return Center(child: Text(state.message));
                }
                if (state is GateEntryListSuccess) {
                  if (state.entries.isEmpty) {
                    return const Center(child: Text("No gate entries found"));
                  }
                  return ListView.separated(
                    padding: const EdgeInsets.all(12),
                    itemCount: state.entries.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (context, index) => _GateEntryCard(
                      item: state.entries[index],
                      truckType: widget.truckType,
                      onRefresh: _fetch,
                    ),
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────
// GATE ENTRY CARD
// ─────────────────────────────────────────
class _GateEntryCard extends StatelessWidget {
  final GateEntryModel item;
  final int truckType;
  final VoidCallback onRefresh;

  const _GateEntryCard({
    required this.item,
    required this.truckType,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.local_shipping,
                  color: truckType == 1 ? Colors.green : Colors.orange,
                  size: 26,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    item.vehicleNo,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: truckType == 1
                        ? Colors.green.shade100
                        : Colors.orange.shade100,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    truckType == 1 ? "RAW" : "EMPTY",
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: truckType == 1 ? Colors.green : Colors.orange,
                    ),
                  ),
                ),
              ],
            ),

            const Divider(height: 20),

            if (truckType == 1)
              _infoRow(
                Icons.business,
                "Party ID",
                item.partyId?.toString() ?? "-",
              ),
            if (truckType == 1)
              _infoRow(Icons.receipt_long, "Invoice", item.invoiceId ?? "-"),
            _infoRow(Icons.person, "Driver", item.driverName),
            _infoRow(Icons.phone, "Mobile", item.driverMobileNo.toString()),
            _infoRow(Icons.scale, "Weight", item.vehicleWeight.toString()),

            const SizedBox(height: 16),

            // ── Exit Button ──
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.exit_to_app, color: Colors.white),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: () => _showExitDialog(context),
                label: const Text(
                  "Mark as Exited",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.grey),
          const SizedBox(width: 8),
          Text("$label: ", style: const TextStyle(fontWeight: FontWeight.w600)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  void _showExitDialog(BuildContext context) {
    final weightCtrl = TextEditingController(
      text: item.vehicleWeight.toString(),
    );

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Confirm Exit"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Enter out vehicle weight to confirm exit:"),
            const SizedBox(height: 12),
            TextField(
              controller: weightCtrl,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Out Vehicle Weight",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            onPressed: () {
              Navigator.pop(context);
              final now = DateTime.now();
              context.read<GateExitBloc>().add(
                SubmitGateExitEvent(
                  id: item.id,
                  truckType: truckType,
                  outVehicleWeight:
                      int.tryParse(weightCtrl.text) ?? item.vehicleWeight,
                  exitDate: DateFormat('yyyy-MM-dd').format(now),
                  exitTime: DateFormat('HH:mm').format(now),
                ),
              );
              onRefresh();
            },
            child: const Text(
              "Confirm Exit",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────
// TAB 2 — Gate Exits
// ─────────────────────────────────────────
class _GateExitsTab extends StatelessWidget {
  const _GateExitsTab();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
              tabs: const [
                Tab(text: 'Filled Truck'),
                Tab(text: 'Empty Truck'),
              ],
            ),
          ),
          const Expanded(
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                _GateExitList(truckType: 1),
                _GateExitList(truckType: 2),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────
// GATE EXIT LIST WITH DATE PICKER
// ─────────────────────────────────────────
class _GateExitList extends StatefulWidget {
  final int truckType;
  const _GateExitList({required this.truckType});

  @override
  State<_GateExitList> createState() => _GateExitListState();
}

class _GateExitListState extends State<_GateExitList> {
  late String selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    _fetch();
  }

  void _fetch() {
    context.read<GateExitBloc>().add(
      FetchGateExitsEvent(truckType: widget.truckType, exitDate: selectedDate),
    );
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.tryParse(selectedDate) ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        selectedDate = DateFormat('yyyy-MM-dd').format(picked);
      });
      _fetch();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GateExitBloc, GateExitState>(
      listener: (context, state) {
        if (state is GateExitUpdateSuccess) {
          Navigator.pop(context);
          snackbar(
            context,
            color: Colors.green,
            title: "Updated",
            message: state.message,
          );
          _fetch();
        }
        if (state is GateExitUpdateFailure) {
          snackbar(
            context,
            color: Colors.red,
            title: "Error",
            message: state.message,
          );
        }
        if (state is GateExitDeleteSuccess) {
          snackbar(
            context,
            color: Colors.green,
            title: "Deleted",
            message: state.message,
          );
          _fetch();
        }
        if (state is GateExitDeleteFailure) {
          snackbar(
            context,
            color: Colors.red,
            title: "Error",
            message: state.message,
          );
        }
      },
      child: Column(
        children: [
          // ── Date Picker ──
          _DatePickerBar(date: selectedDate, onTap: _pickDate),

          // ── List ──
          Expanded(
            child: BlocBuilder<GateExitBloc, GateExitState>(
              builder: (context, state) {
                if (state is GateExitListLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is GateExitListFailure) {
                  return Center(child: Text(state.message));
                }
                if (state is GateExitListSuccess) {
                  if (state.exits.isEmpty) {
                    return const Center(child: Text("No gate exits found"));
                  }
                  return ListView.separated(
                    padding: const EdgeInsets.all(12),
                    itemCount: state.exits.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (context, index) => _GateExitCard(
                      item: state.exits[index],
                      truckType: widget.truckType,
                    ),
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────
// GATE EXIT CARD
// ─────────────────────────────────────────
class _GateExitCard extends StatelessWidget {
  final GateExitModel item;
  final int truckType;

  const _GateExitCard({required this.item, required this.truckType});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.exit_to_app,
                  color: truckType == 1 ? Colors.green : Colors.orange,
                  size: 26,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    item.vehicleNo,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: truckType == 1
                        ? Colors.green.shade100
                        : Colors.orange.shade100,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    truckType == 1 ? "RAW" : "EMPTY",
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: truckType == 1 ? Colors.green : Colors.orange,
                    ),
                  ),
                ),
              ],
            ),

            const Divider(height: 20),

            _infoRow(Icons.calendar_today, "Entry Date", item.date),
            _infoRow(Icons.access_time, "Entry Time", item.time),
            _infoRow(Icons.logout, "Exit Date", item.exitDate),
            _infoRow(Icons.access_time_filled, "Exit Time", item.exitTime),
            _infoRow(Icons.person, "Driver", item.driverName),
            _infoRow(Icons.phone, "Mobile", item.driverMobileNo),
            _infoRow(Icons.business, "Party", item.partyName),
            if (item.invoiceId != null)
              _infoRow(Icons.receipt, "Invoice", item.invoiceId!),
            _infoRow(Icons.scale, "In Weight", item.vehicleWeight.toString()),
            _infoRow(
              Icons.scale_outlined,
              "Out Weight",
              item.outVehicleWeight.toString(),
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                    ),
                    onPressed: () => _showUpdateDialog(context),
                    label: const Text(
                      "Update",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                    ),
                    onPressed: () => _showDeleteDialog(context),
                    label: const Text(
                      "Delete",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.grey),
          const SizedBox(width: 8),
          Text("$label: ", style: const TextStyle(fontWeight: FontWeight.w600)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  void _showUpdateDialog(BuildContext context) {
    final weightCtrl = TextEditingController(
      text: item.outVehicleWeight.toString(),
    );

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Update Gate Exit"),
        content: TextField(
          controller: weightCtrl,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: "Out Vehicle Weight",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<GateExitBloc>().add(
                UpdateGateExitEvent(
                  id: item.id,
                  truckType: truckType,
                  outVehicleWeight:
                      int.tryParse(weightCtrl.text) ?? item.outVehicleWeight,
                ),
              );
            },
            child: const Text("Update"),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Delete Exit"),
        content: const Text("Are you sure you want to delete this exit?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              Navigator.pop(context);
              context.read<GateExitBloc>().add(
                DeleteGateExitEvent(id: item.id, truckType: truckType),
              );
            },
            child: const Text("Delete", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────
// SHARED DATE PICKER BAR
// ─────────────────────────────────────────
class _DatePickerBar extends StatelessWidget {
  final String date;
  final VoidCallback onTap;

  const _DatePickerBar({required this.date, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.fromLTRB(12, 8, 12, 4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade300),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(Icons.calendar_today, size: 18, color: AppColors.primary),
            const SizedBox(width: 10),
            Text(
              date,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
            const Spacer(),
            Icon(Icons.arrow_drop_down, color: Colors.grey[600]),
          ],
        ),
      ),
    );
  }
}
