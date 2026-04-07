import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:inventory_mobile_app/core/consts/appcolors.dart';
import 'package:inventory_mobile_app/core/consts/snack_bar.dart';
import 'package:inventory_mobile_app/features/master/bloc/master_bloc.dart';
import 'package:inventory_mobile_app/features/master/bloc/master_event.dart';
import 'package:inventory_mobile_app/features/master/bloc/master_state.dart';
import 'package:inventory_mobile_app/features/master/master_model/bottle_combination_model.dart';
import 'package:inventory_mobile_app/features/master/master_model/mapping_bottle_model.dart';
import 'package:inventory_mobile_app/features/unloading/bloc/bottle_list_bloc/bottle_list_bloc.dart';
import 'package:inventory_mobile_app/features/unloading/bloc/unloading_bloc.dart';
import 'package:inventory_mobile_app/features/unloading/bloc/unloading_event.dart';
import 'package:inventory_mobile_app/features/unloading/bloc/unloading_state.dart';
import 'package:inventory_mobile_app/features/unloading/models/bottleunloading_model.dart';
import 'package:inventory_mobile_app/features/unloading/repository/unloading_repository.dart';
import 'package:inventory_mobile_app/widgets/appdropdown.dart';

class BottleCreateScreen extends StatefulWidget {
  const BottleCreateScreen({super.key});

  @override
  State<BottleCreateScreen> createState() => _BottleCreateScreenState();
}

class _BottleCreateScreenState extends State<BottleCreateScreen> {
  final _formKey = GlobalKey<FormState>();

  final palletCodeController = TextEditingController();
  final casesQtyController = TextEditingController();

  List<MappingBottleModel> _mappingList = [];
  List<BottleCombinationModel> _combinationList = [];

  MappingBottleModel? selectedMapping;
  BottleCombinationModel? selectedCombination;
  DateTime fromDate = DateTime.now().subtract(const Duration(days: 30));
  DateTime toDate = DateTime.now();

  String formatDate(DateTime date) => DateFormat('yyyy-MM-dd').format(date);

  @override
  void dispose() {
    palletCodeController.dispose();
    casesQtyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => MasterBloc()
            ..add(FetchMappingBottleEvent())
            ..add(FetchCombinationBottleEvent()),
        ),
        BlocProvider(create: (_) => UnloadingBloc(repo: UnloadingRepository())),
        BlocProvider(
          create: (_) => BottleListBloc(repo: UnloadingRepository())
            ..add(
              FetchBottleListEvent(
                fromDate: formatDate(fromDate),
                toDate: formatDate(toDate),
              ),
            ),
        ),
      ],
      child: Builder(
        builder: (context) {
          return BlocListener<MasterBloc, MasterState>(
            listener: (context, state) {
              if (state is GetMappingBottleListSuccess) {
                final unique = {
                  for (var item in state.mappingBottles) item.id: item,
                };
                setState(() => _mappingList = unique.values.toList());
              }
              if (state is GetCombinationBottleListSuccess) {
                final unique = {
                  for (var item in state.combinations) item.id: item,
                };
                setState(() => _combinationList = unique.values.toList());
              }
            },
            child: BlocListener<UnloadingBloc, UnloadingState>(
              listener: (context, state) {
                if (state is BottleEntrySuccess) {
                  snackbar(
                    context,
                    color: Colors.green,
                    message: state.message,
                    title: "Success",
                  );
                  // refresh list
                  context.read<BottleListBloc>().add(
                    FetchBottleListEvent(
                      fromDate: DateFormat('yyyy-MM-dd').format(
                        DateTime.now().subtract(const Duration(days: 30)),
                      ),
                      toDate: DateFormat('yyyy-MM-dd').format(DateTime.now()),
                    ),
                  );
                  _resetForm();
                }
                if (state is BottleEntryFailure) {
                  snackbar(context, message: state.error);
                }
              },
              child: Scaffold(
                backgroundColor: AppColors.background,

                body: SafeArea(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        _dateFilter(context), // 👈 ADD THIS
                        // ── Create Form ──
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 8,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: ExpansionTile(
                            backgroundColor: Colors.white,
                            initiallyExpanded: true,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            tilePadding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 4,
                            ),
                            childrenPadding: const EdgeInsets.fromLTRB(
                              20,
                              0,
                              20,
                              20,
                            ),
                            leading: CircleAvatar(
                              backgroundColor: AppColors.primary.withOpacity(
                                0.1,
                              ),
                              child: Icon(Icons.add, color: AppColors.primary),
                            ),
                            title: const Text(
                              "Create Bottle Entry",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                            subtitle: const Text(
                              "Fill in the details below",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                            children: [
                              Form(
                                key: _formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 5),
                                    _textField(
                                      "Pallet Unique Code",
                                      palletCodeController,
                                    ),
                                    _numberField(
                                      "Cases Quantity",
                                      casesQtyController,
                                    ),

                                    // ── Mapping Dropdown ──
                                    // Mapping
                                    AppDropdown<MappingBottleModel>(
                                      title: "Mapping Bottle",
                                      hint: "Select",
                                      items: _mappingList,
                                      value: selectedMapping,
                                      itemLabel: (item) =>
                                          "${item.brandName} - ${item.bottleSize}ml",
                                      isRequired: true,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedMapping = value;
                                          selectedCombination = null;
                                        });
                                      },
                                    ),

                                    const SizedBox(height: 14),

                                    // Combination
                                    AppDropdown<BottleCombinationModel>(
                                      title: "Combination Bottle",
                                      hint: "Select",
                                      items: _combinationList,
                                      value: selectedCombination,
                                      itemLabel: (item) =>
                                          "${item.bottleSize}ml - ${item.caseSize}",
                                      isRequired: true,
                                      onChanged: (value) {
                                        setState(
                                          () => selectedCombination = value,
                                        );
                                      },
                                    ),
                                    const SizedBox(height: 24),

                                    // ── Buttons ──
                                    BlocBuilder<UnloadingBloc, UnloadingState>(
                                      builder: (context, state) {
                                        return Row(
                                          children: [
                                            Expanded(
                                              child: OutlinedButton(
                                                onPressed: _resetForm,
                                                child: const Text("RESET"),
                                              ),
                                            ),
                                            const SizedBox(width: 12),
                                            Expanded(
                                              child: ElevatedButton(
                                                onPressed:
                                                    state is BottleEntryLoading
                                                    ? null
                                                    : _submit,
                                                child:
                                                    state is BottleEntryLoading
                                                    ? const SizedBox(
                                                        height: 18,
                                                        width: 18,
                                                        child:
                                                            CircularProgressIndicator(
                                                              strokeWidth: 2,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                      )
                                                    : const Text("SUBMIT"),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 16),

                        // ── List ──
                        BlocBuilder<BottleListBloc, BottleListState>(
                          builder: (context, state) {
                            if (state is BottleListLoading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (state is BottleListFailure) {
                              return Center(
                                child: Text(
                                  state.error,
                                  style: const TextStyle(color: Colors.red),
                                ),
                              );
                            }
                            if (state is BottleListSuccess) {
                              if (state.list.isEmpty) {
                                return Center(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.water_drop_outlined,
                                        size: 64,
                                        color: Colors.grey[300],
                                      ),
                                      const SizedBox(height: 12),
                                      Text(
                                        "No bottle entries found",
                                        style: TextStyle(
                                          color: Colors.grey[400],
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }
                              return ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: state.list.length,
                                separatorBuilder: (_, __) =>
                                    const SizedBox(height: 8),
                                itemBuilder: (context, index) =>
                                    _BottleEntryTile(
                                      entry: state.list[index],
                                      mappingList: _mappingList,
                                      combinationList: _combinationList,
                                    ),
                              );
                            }
                            return const SizedBox.shrink();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _dateFilter(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextButton(
            onPressed: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: fromDate,
                firstDate: DateTime(2020),
                lastDate: DateTime.now(),
              );
              if (picked != null) {
                setState(() => fromDate = picked);
                _refreshList(context);
              }
            },
            child: Text("From: ${formatDate(fromDate)}"),
          ),
        ),
        Expanded(
          child: TextButton(
            onPressed: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: toDate,
                firstDate: DateTime(2020),
                lastDate: DateTime.now(),
              );
              if (picked != null) {
                setState(() => toDate = picked);
                _refreshList(context);
              }
            },
            child: Text("To: ${formatDate(toDate)}"),
          ),
        ),
      ],
    );
  }

  void _refreshList(BuildContext context) {
    context.read<BottleListBloc>().add(
      FetchBottleListEvent(
        fromDate: formatDate(fromDate),
        toDate: formatDate(toDate),
      ),
    );
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    if (selectedMapping == null) {
      snackbar(context, message: "Please select mapping bottle");
      return;
    }
    if (selectedCombination == null) {
      snackbar(context, message: "Please select combination bottle");
      return;
    }

    context.read<UnloadingBloc>().add(
      SubmitBottleEntry(
        palletCode: palletCodeController.text.trim(),
        casesQuantity: int.parse(casesQtyController.text.trim()),
        mappingBottle: selectedMapping!.id!,
        combinationBottleBoxes: selectedCombination!.id!,
      ),
    );
  }

  void _resetForm() {
    _formKey.currentState?.reset();

    palletCodeController.clear();
    casesQtyController.clear();
    setState(() {
      selectedMapping = null;
      selectedCombination = null;
    });
  }

  Widget _textField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextFormField(
        controller: controller,
        validator: (v) =>
            v == null || v.trim().isEmpty ? "$label is required" : null,
        decoration: _inputDecoration(label),
      ),
    );
  }

  Widget _numberField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        validator: (v) {
          if (v == null || v.trim().isEmpty) return "$label is required";
          if (int.tryParse(v) == null) return "Enter valid number";
          return null;
        },
        decoration: _inputDecoration(label),
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.grey.shade100,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }
}

// ─────────────────────────────────────────
// EXPANSION TILE LIST ITEM
// ─────────────────────────────────────────
class _BottleEntryTile extends StatelessWidget {
  final List<MappingBottleModel> mappingList;
  final List<BottleCombinationModel> combinationList;
  final BottleUnloadingModel entry;

  const _BottleEntryTile({
    required this.entry,
    required this.mappingList,
    required this.combinationList,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 1.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        childrenPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        leading: CircleAvatar(
          backgroundColor: AppColors.primary.withOpacity(0.1),
          child: Text(
            "${entry.bottleSize}",
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          entry.palletUniqueCode ?? "-",
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
        subtitle: Text(
          "${entry.brandName} • ${entry.date}",
          style: TextStyle(color: Colors.grey[600], fontSize: 12),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                "${entry.bottleAvailable} avail.",
                style: TextStyle(
                  color: Colors.green[700],
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Icon(Icons.expand_more),
          ],
        ),
        children: [
          const Divider(),
          _infoGrid(),
          const SizedBox(height: 4),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    // TODO: handle update
                    _openUpdateSheet(context, entry);
                  },
                  icon: const Icon(Icons.edit, size: 18),
                  label: const Text("Update"),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    side: BorderSide(color: AppColors.primary.withOpacity(0.5)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    _showDeleteDialog(context, entry.id!);
                  },
                  icon: const Icon(Icons.delete, size: 18),
                  label: const Text("Delete"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade500,
                    foregroundColor: Colors.white,
                    elevation: 1.5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, int id) {
    final bloc = context.read<UnloadingBloc>();

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("Delete Entry"),
          content: const Text("Are you sure you want to delete this entry?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                bloc.add(DeleteBottleEntry(id: id));
                Navigator.pop(context);
              },
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  void _openUpdateSheet(BuildContext context, BottleUnloadingModel entry) {
    final palletController = TextEditingController(
      text: entry.palletUniqueCode ?? "",
    );
    final casesController = TextEditingController(
      text: entry.casesQuantity?.toString() ?? "",
    );
    MappingBottleModel? selectedMapping =
        mappingList.where((e) => e.id == entry.mappingBottle).isNotEmpty
        ? mappingList.firstWhere((e) => e.id == entry.mappingBottle)
        : null;

    BottleCombinationModel? selectedCombination =
        combinationList
            .where((e) => e.id == entry.combinationBottleBoxes)
            .isNotEmpty
        ? combinationList.firstWhere(
            (e) => e.id == entry.combinationBottleBoxes,
          )
        : null;

    final unloadingBloc = context.read<UnloadingBloc>(); // 👈 ADD THIS

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16,
                bottom: MediaQuery.of(context).viewInsets.bottom + 16,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Update Bottle Entry",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),

                    TextField(
                      controller: palletController,
                      decoration: _sheetInputDecoration("Pallet Code"),
                    ),

                    const SizedBox(height: 10),

                    TextField(
                      controller: casesController,
                      keyboardType: TextInputType.number,
                      decoration: _sheetInputDecoration("Cases Quantity"),
                    ),

                    const SizedBox(height: 10),

                    AppDropdown<MappingBottleModel>(
                      title: "Mapping Bottle",
                      hint: "Select",
                      items: mappingList,
                      value:
                          mappingList
                              .where((e) => e.id == selectedMapping?.id)
                              .isNotEmpty
                          ? mappingList.firstWhere(
                              (e) => e.id == selectedMapping?.id,
                            )
                          : null,
                      itemLabel: (item) =>
                          "${item.brandName} - ${item.bottleSize}ml",
                      onChanged: (val) {
                        setModalState(() => selectedMapping = val);
                      },
                    ),

                    const SizedBox(height: 10),

                    AppDropdown<BottleCombinationModel>(
                      title: "Combination Bottle",
                      hint: "Select",
                      items: combinationList,
                      value:
                          combinationList
                              .where((e) => e.id == selectedCombination?.id)
                              .isNotEmpty
                          ? combinationList.firstWhere(
                              (e) => e.id == selectedCombination?.id,
                            )
                          : null,
                      itemLabel: (item) =>
                          "${item.bottleSize}ml - ${item.caseSize}",
                      onChanged: (val) {
                        setModalState(() => selectedCombination = val);
                      },
                    ),

                    const SizedBox(height: 20),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          unloadingBloc.add(
                            // 👈 USE THIS
                            UpdateBottleEntry(
                              id: entry.id!,
                              palletCode: palletController.text.trim(),
                              casesQuantity: int.parse(
                                casesController.text.trim(),
                              ),
                              mappingBottle: selectedMapping!.id!,
                              combinationBottleBoxes: selectedCombination!.id!,
                            ),
                          );

                          Navigator.pop(context);
                        },
                        child: const Text("UPDATE"),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  InputDecoration _sheetInputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.grey.shade100,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
    );
  }

  Widget _infoGrid() {
    final items = [
      _InfoItem("Date", entry.date ?? "-"),
      _InfoItem("Time", entry.time ?? "-"),
      _InfoItem("Gate ID", entry.gateId?.toString() ?? "-"),
      _InfoItem("Vehicle No", entry.vehicleNo ?? "-"),
      _InfoItem("Party", entry.partyName ?? "-"),
      _InfoItem("Brand", entry.brandName ?? "-"),
      _InfoItem("Bottle Size", "${entry.bottleSize}ml"),
      _InfoItem("Box Size", entry.boxSize?.toString() ?? "-"),
      _InfoItem("Cases Qty", entry.casesQuantity?.toString() ?? "-"),
      _InfoItem("Cases Avail.", entry.casesAvailable?.toString() ?? "-"),
      _InfoItem("Total Bottles", entry.totalBottle?.toString() ?? "-"),
      _InfoItem("Bottles Avail.", entry.bottleAvailable?.toString() ?? "-"),
      _InfoItem("Combo Boxes", entry.combinationBottleBoxes?.toString() ?? "-"),
      _InfoItem("Created By", entry.createdBy ?? "-"),
      _InfoItem("Updated By", entry.updatedBy ?? "-"),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3.2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 4,
      ),
      itemCount: items.length,
      itemBuilder: (_, i) => _infoItem(items[i].label, items[i].value),
    );
  }

  Widget _infoItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey[500],
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

class _InfoItem {
  final String label;
  final String value;
  const _InfoItem(this.label, this.value);
}
