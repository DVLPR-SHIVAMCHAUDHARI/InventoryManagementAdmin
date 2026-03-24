import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:inventory_mobile_app/core/consts/appcolors.dart';

import 'package:inventory_mobile_app/core/consts/snack_bar.dart';
import 'package:inventory_mobile_app/features/gate_operations/gate_entries/bloc/gate_entry_bloc.dart';
import 'package:inventory_mobile_app/features/gate_operations/gate_entries/bloc/gate_entry_event.dart';
import 'package:inventory_mobile_app/features/gate_operations/gate_entries/bloc/gate_entry_state.dart';
import 'package:inventory_mobile_app/features/gate_operations/gate_entries/models/gate_Entry_model.dart';
import 'package:inventory_mobile_app/features/gate_operations/gate_exits/bloc/gate_exit_bloc.dart';
import 'package:inventory_mobile_app/features/gate_operations/gate_exits/bloc/gate_exit_event.dart';
import 'package:inventory_mobile_app/features/gate_operations/gate_exits/bloc/gate_exit_state.dart';

class PastEntriesPage extends StatefulWidget {
  const PastEntriesPage({super.key});

  @override
  State<PastEntriesPage> createState() => _PastEntriesPageState();
}

class _PastEntriesPageState extends State<PastEntriesPage> {
  int truckType = 1; // 1 = Raw, 2 = Empty

  @override
  void initState() {
    super.initState();
    _fetch();
  }

  void _fetch() {
    final date = DateTime.now().toString().split(' ')[0];

    context.read<GateEntryBloc>().add(
      FetchGateEntries(truckType: truckType, date: date),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      body: SafeArea(
        child: MultiBlocListener(
          listeners: [
            /// ENTRY
            BlocListener<GateEntryBloc, GateEntryState>(
              listener: (context, state) {
                if (state is GateEntryUpdateSuccess) {
                  Navigator.pop(context);

                  snackbar(
                    context,
                    color: Colors.green,
                    title: "Success",
                    message: state.message,
                  );

                  _fetch();
                }

                if (state is GateEntryUpdateFailure) {
                  snackbar(
                    context,
                    color: Colors.red,
                    title: "Error",
                    message: state.message,
                  );
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
            ),

            /// 🔥 EXIT (THIS WAS MISSING PROPERLY)
            BlocListener<GateExitBloc, GateExitState>(
              listener: (context, state) {
                if (state is GateExitSuccess) {
                  snackbar(
                    context,
                    color: Colors.green,
                    title: "Exited",
                    message: state.message,
                  );

                  _fetch(); // 🔥 refresh list
                }

                if (state is GateExitFailure) {
                  snackbar(
                    context,
                    color: Colors.red,
                    title: "Error",
                    message: state.message,
                  );
                }
              },
            ),
          ],
          child: Column(
            children: [
              /// 🔥 TOGGLE
              Padding(padding: const EdgeInsets.all(12), child: _toggle()),
              BlocListener<GateEntryBloc, GateEntryState>(
                listener: (context, state) {
                  if (state is GateEntryUpdateSuccess) {
                    Navigator.pop(context); // close dialog

                    snackbar(
                      context,
                      color: Colors.green,
                      title: "Success",
                      message: state.message,
                    );

                    _fetch(); // 🔥 refresh list
                  }

                  if (state is GateEntryUpdateFailure) {
                    snackbar(
                      context,
                      color: Colors.red,
                      title: "Error",
                      message: state.message,
                    );
                  }
                  if (state is GateEntryDeleteSuccess) {
                    snackbar(
                      context,
                      color: Colors.green,
                      title: "Deleted",
                      message: state.message,
                    );

                    _fetch(); // 🔥 refresh list
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

                child: SizedBox.shrink(),
              ),
              BlocListener<GateExitBloc, GateExitState>(
                listener: (context, state) {
                  if (state is GateExitSuccess) {
                    snackbar(
                      context,
                      color: Colors.green,
                      title: "Exited",
                      message: state.message,
                    );

                    _fetch(); // refresh list
                  }

                  if (state is GateExitFailure) {
                    snackbar(
                      context,
                      color: Colors.red,
                      title: "Error",
                      message: state.message,
                    );
                  }
                },
                child: SizedBox.shrink(),
              ),

              /// 🔥 LIST
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
                      final list = state.entries;

                      if (list.isEmpty) {
                        return const Center(
                          child: Text("No gate entries found"),
                        );
                      }

                      return ListView.separated(
                        padding: const EdgeInsets.all(12),
                        itemCount: list.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 10),
                        itemBuilder: (context, index) {
                          final item = list[index];
                          return _gateEntryCard(item);
                        },
                      );
                    }

                    return const SizedBox();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// ---------------- TOGGLE ----------------

  Widget _toggle() {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() => truckType = 1);
              _fetch();
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: truckType == 1 ? Colors.green : Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.green),
              ),
              child: Center(
                child: Text(
                  "Filled Truck",
                  style: TextStyle(
                    color: truckType == 1 ? Colors.white : Colors.green,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() => truckType = 2);
              _fetch();
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: truckType == 2 ? Colors.orange : Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.orange),
              ),
              child: Center(
                child: Text(
                  "Empty Truck",
                  style: TextStyle(
                    color: truckType == 2 ? Colors.white : Colors.orange,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// ---------------- CARD ----------------

  Widget _gateEntryCard(GateEntryModel item) {
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
            /// HEADER
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
              _infoRow(Icons.business, "Party ID", item.partyId.toString()),

            if (truckType == 1)
              _infoRow(Icons.receipt_long, "Invoice", item.invoiceId!),

            _infoRow(Icons.person, "Driver", item.driverName),
            _infoRow(Icons.phone, "Mobile", item.driverMobileNo.toString()),
            _infoRow(Icons.scale, "Weight", item.vehicleWeight.toString()),

            const SizedBox(height: 16),

            /// ACTIONS
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                    ),
                    onPressed: () => _updateEntry(item, context),
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
                    onPressed: () => _delete(item),
                    label: const Text(
                      "Delete",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.exit_to_app, color: Colors.green),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                    ),
                    onPressed: () => _confirm(item),
                    label: const Text(
                      "Exit",
                      style: TextStyle(color: Colors.green),
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

  /// ---------------- HELPERS ----------------

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

  void _delete(GateEntryModel item) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Delete Entry"),
        content: const Text("Are you sure?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<GateEntryBloc>().add(
                DeleteGateEntryEvent(id: item.id, truckType: truckType),
              );
            },
            child: const Text("Delete"),
          ),
        ],
      ),
    );
  }

  void _confirm(GateEntryModel item) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Confirm Exit"),
        content: const Text("Mark vehicle as exited?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);

              context.read<GateExitBloc>().add(
                SubmitGateExitEvent(
                  id: item.id,
                  truckType: truckType,
                  outVehicleWeight: item.vehicleWeight, // or input

                  exitDate: DateTime.now().toString().split(' ')[0],
                  exitTime: _formatTime(),
                ),
              );
            },
            child: const Text("Yes"),
          ),
        ],
      ),
    );
  }

  void _updateEntry(GateEntryModel item, BuildContext context) {
    final driverCtrl = TextEditingController(text: item.driverName);
    final vehicleCtrl = TextEditingController(text: item.vehicleNo);
    final weightCtrl = TextEditingController(
      text: item.vehicleWeight.toString(),
    );
    final mobileCtrl = TextEditingController(text: item.driverMobileNo);

    final invoiceCtrl = TextEditingController(text: item.invoiceId ?? "");
    final partyCtrl = TextEditingController(
      text: item.partyId?.toString() ?? "",
    );

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("Update Gate Entry"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                _field(driverCtrl, "Driver Name"),
                _field(vehicleCtrl, "Vehicle No"),
                _field(weightCtrl, "Vehicle Weight"),
                _field(mobileCtrl, "Driver Mobile"),

                /// ✅ Only for RAW
                if (truckType == 1) _field(invoiceCtrl, "Invoice"),
                if (truckType == 1) _field(partyCtrl, "Party ID"),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<GateEntryBloc>().add(
                  UpdateGateEntryEvent(
                    id: item.id,
                    truckType: truckType,

                    driverName: driverCtrl.text.trim(),
                    vehicleNo: vehicleCtrl.text.trim(),
                    vehicleWeight: int.tryParse(weightCtrl.text) ?? 0,
                    driverMobileNo: mobileCtrl.text.trim(),

                    date: DateTime.now().toString().split(' ')[0],
                    time: _formatTime(),

                    invoiceId: truckType == 1 ? invoiceCtrl.text.trim() : null,
                    partyId: truckType == 1
                        ? int.tryParse(partyCtrl.text)
                        : null,
                  ),
                );
              },
              child: const Text("Update"),
            ),
          ],
        );
      },
    );
  }

  String _formatTime() {
    final now = TimeOfDay.now();
    return "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";
  }
}

/// ---------------- FIELD ----------------

Widget _field(TextEditingController controller, String label) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
  );
}
