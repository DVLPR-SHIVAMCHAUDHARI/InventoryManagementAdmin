import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:inventory_mobile_app/core/consts/appcolors.dart';
import 'package:inventory_mobile_app/core/consts/snack_bar.dart';
import 'package:inventory_mobile_app/features/master/bloc/bottle_size_bloc.dart';
import 'package:inventory_mobile_app/features/master/bloc/brand_bloc.dart';

import 'package:inventory_mobile_app/features/master/bloc/master_bloc.dart';
import 'package:inventory_mobile_app/features/master/bloc/master_event.dart';
import 'package:inventory_mobile_app/features/master/bloc/master_party_bloc.dart';
import 'package:inventory_mobile_app/features/master/bloc/master_state.dart';
import 'package:inventory_mobile_app/features/master/master_model/brand_model.dart';
import 'package:inventory_mobile_app/features/master/master_model/mapping_label_model.dart';
import 'package:inventory_mobile_app/features/master/master_model/party_model.dart';

import 'package:inventory_mobile_app/features/unloading/bloc/label_list_bloc/label_list_bloc.dart';
import 'package:inventory_mobile_app/features/unloading/bloc/unloading_bloc.dart';
import 'package:inventory_mobile_app/features/unloading/bloc/unloading_event.dart';
import 'package:inventory_mobile_app/features/unloading/bloc/unloading_state.dart';
import 'package:inventory_mobile_app/features/unloading/models/label_unloading_model.dart';
import 'package:inventory_mobile_app/features/unloading/repository/unloading_repository.dart';

import 'package:inventory_mobile_app/widgets/appdropdown.dart';

class LabelCreateScreen extends StatefulWidget {
  const LabelCreateScreen({super.key});

  @override
  State<LabelCreateScreen> createState() => _LabelCreateScreenState();
}

enum LabelSearchType { pallet, vehicle }

class _LabelCreateScreenState extends State<LabelCreateScreen> {
  final _formKey = GlobalKey<FormState>();
  LabelSearchType selectedSearch = LabelSearchType.pallet;
  String orderBy = "asc"; // default value
  final searchController = TextEditingController();

  Timer? _debounce;

  final palletController = TextEditingController();
  final casesController = TextEditingController();
  final rollController = TextEditingController();
  final labelController = TextEditingController();

  List<MappingLabelModel> _mappingList = [];
  MappingLabelModel? selectedMapping;

  DateTime fromDate = DateTime.now().subtract(const Duration(days: 30));
  DateTime toDate = DateTime.now();

  String formatDate(DateTime date) => DateFormat('yyyy-MM-dd').format(date);
  String? palletSearch;
  String? vehicleSearch;

  int? selectedPartyId;
  int? selectedBrandId;
  int? selectedSizeId;
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<LabelListBloc>().add(
        FetchLabelListEvent(
          fromDate: formatDate(fromDate),
          toDate: formatDate(toDate),
        ),
      );
    });
  }

  @override
  void dispose() {
    palletController.dispose();
    casesController.dispose();
    rollController.dispose();
    labelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return BlocListener<MasterBloc, MasterState>(
          listener: (context, state) {
            if (state is GetMappingLabelListSuccess) {
              final unique = {
                for (var item in state.mappingLabels) item.id: item,
              };
              setState(() => _mappingList = unique.values.toList());
            }
          },
          child: BlocListener<UnloadingBloc, UnloadingState>(
            listener: (context, state) {
              if (state is LabelEntrySuccess) {
                snackbar(
                  context,
                  color: Colors.green,
                  message: state.message,
                  title: "Success",
                );
                _refreshList(context);
                _resetForm();
              }

              if (state is LabelEntryFailure) {
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
                      _formCard(),
                      const SizedBox(height: 12),
                      _dateFilter(context),
                      const SizedBox(height: 12),
                      // 🔍 Search Type
                      DropdownButtonFormField<LabelSearchType>(
                        value: selectedSearch,
                        isExpanded: true,
                        decoration: _input("Search By"),
                        icon: const Icon(Icons.keyboard_arrow_down_rounded),
                        items: const [
                          DropdownMenuItem(
                            value: LabelSearchType.pallet,
                            child: Text("Pallet Code"),
                          ),
                          DropdownMenuItem(
                            value: LabelSearchType.vehicle,
                            child: Text("Vehicle No"),
                          ),
                        ],
                        onChanged: (val) {
                          setState(() {});
                          (() => selectedSearch = val!);
                        },
                      ),
                      const SizedBox(height: 12),
                      _topSearchBar(),

                      const SizedBox(height: 16),
                      _listSection(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _topSearchBar() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: searchController,
            decoration: InputDecoration(
              hintText: selectedSearch == LabelSearchType.pallet
                  ? "Search Pallet Code..."
                  : "Search Vehicle No...",
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.grey.shade100,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
            onChanged: (value) {
              if (_debounce?.isActive ?? false) _debounce!.cancel();

              _debounce = Timer(const Duration(milliseconds: 400), () {
                if (selectedSearch == LabelSearchType.pallet) {
                  palletSearch = value;
                  vehicleSearch = null;
                } else {
                  vehicleSearch = value;
                  palletSearch = null;
                }

                _triggerSearch();
              });
            },
          ),
        ),
        const SizedBox(width: 10),

        // 🔥 FILTER BUTTON
        InkWell(
          onTap: _openFilterSheet,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.tune, color: Colors.white),
          ),
        ),
      ],
    );
  }

  void _openFilterSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return MultiBlocProvider(
          providers: [
            BlocProvider.value(value: context.read<PartyBloc>()),
            BlocProvider.value(value: context.read<BrandBloc>()),
            BlocProvider.value(value: context.read<BottleSizeBloc>()),
          ],
          child: StatefulBuilder(
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
                        "Filters",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 16),

                      const SizedBox(height: 12),

                      // 🔽 PARTY
                      BlocBuilder<PartyBloc, PartyState>(
                        builder: (context, state) {
                          return AppDropdown<PartyModel>(
                            title: "Party",
                            hint: "Select",
                            items: state is PartyLoaded ? state.parties : [],
                            value: null,
                            itemLabel: (item) => item.name!,
                            onChanged: (val) {
                              setModalState(() {
                                selectedPartyId = val?.id;
                              });
                            },
                          );
                        },
                      ),

                      const SizedBox(height: 12),

                      // 🔽 BRAND
                      BlocBuilder<BrandBloc, BrandState>(
                        builder: (context, state) {
                          return AppDropdown<BrandModel>(
                            title: "Brand",
                            hint: "Select",
                            items: state is BrandLoaded ? state.brands : [],
                            value: null,
                            itemLabel: (item) => item.name!,
                            onChanged: (val) {
                              setModalState(() {
                                selectedBrandId = val?.id;
                              });
                            },
                          );
                        },
                      ),

                      const SizedBox(height: 12),

                      // 🔽 SIZE
                      BlocBuilder<BottleSizeBloc, BottleSizeState>(
                        builder: (context, state) {
                          return AppDropdown(
                            title: "Bottle Size",
                            hint: "Select",
                            items: state is BottleSizeLoaded ? state.sizes : [],
                            value: null,
                            itemLabel: (item) => "${item.size} ml",
                            onChanged: (val) {
                              setModalState(() {
                                selectedSizeId = val?.id;
                              });
                            },
                          );
                        },
                      ),

                      const SizedBox(height: 16),

                      // 🔥 SORT (MODERN UI)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Sort Order",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 8),

                          Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () =>
                                      setModalState(() => orderBy = "asc"),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 12,
                                    ),
                                    decoration: BoxDecoration(
                                      color: orderBy == "asc"
                                          ? AppColors.primary.withOpacity(0.1)
                                          : Colors.grey.shade100,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: orderBy == "asc"
                                            ? AppColors.primary
                                            : Colors.transparent,
                                      ),
                                    ),
                                    child: Text(
                                      "Ascending",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: orderBy == "asc"
                                            ? AppColors.primary
                                            : Colors.black87,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () =>
                                      setModalState(() => orderBy = "desc"),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 12,
                                    ),
                                    decoration: BoxDecoration(
                                      color: orderBy == "desc"
                                          ? AppColors.primary.withOpacity(0.1)
                                          : Colors.grey.shade100,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: orderBy == "desc"
                                            ? AppColors.primary
                                            : Colors.transparent,
                                      ),
                                    ),
                                    child: Text(
                                      "Descending",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: orderBy == "desc"
                                            ? AppColors.primary
                                            : Colors.black87,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // 🔘 ACTIONS
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {
                                _clearFilters();
                                Navigator.pop(context);
                              },
                              child: const Text("RESET"),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                _triggerSearch();
                                Navigator.pop(context);
                              },
                              child: const Text("APPLY"),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  void _clearFilters() {
    palletSearch = null;
    vehicleSearch = null;
    selectedPartyId = null;
    selectedBrandId = null;
    selectedSizeId = null;

    searchController.clear();

    setState(() {});
  }

  void _triggerSearch() {
    context.read<LabelListBloc>().add(
      FetchLabelListEvent(
        fromDate: formatDate(fromDate),
        toDate: formatDate(toDate),

        palletCode: palletSearch,
        vehicleNo: vehicleSearch,

        partyNameId: selectedPartyId,
        brandId: selectedBrandId,
        bottleSizeId: selectedSizeId,
        orderBy: orderBy,
      ),
    );
  }

  // ================= DATE FILTER =================
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

  // ================= FORM =================
  Widget _formCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 3), // 👈 important
          ),
        ],
      ),
      child: ExpansionTile(
        backgroundColor: Colors.white, // 👈 missing in yours
        initiallyExpanded: true,

        tilePadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 4, // 👈 missing
        ),

        childrenPadding: const EdgeInsets.fromLTRB(20, 0, 20, 20),

        leading: CircleAvatar(
          backgroundColor: AppColors.primary.withOpacity(0.1),
          child: Icon(Icons.add, color: AppColors.primary),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: BorderSide.none, // 👈 remove border
        ),
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: BorderSide.none, // 👈 remove border
        ),

        title: const Text(
          "Create Label Entry",
          style: TextStyle(
            fontWeight: FontWeight.w600, // 👈 important
            fontSize: 15,
          ),
        ),

        subtitle: const Text(
          "Fill in the details below",
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),

        children: [
          BlocBuilder<UnloadingBloc, UnloadingState>(
            builder: (context, state) {
              return Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // 👈 important

                  children: [
                    const SizedBox(height: 5), // 👈 spacing fix

                    _field("Pallet Code", palletController),
                    _numberField("Cases", casesController),
                    _numberField("Roll per Case", rollController),
                    _numberField("Label per Roll", labelController),

                    AppDropdown<MappingLabelModel>(
                      title: "Mapping Label",
                      hint: "Select",
                      items: _mappingList,
                      value: selectedMapping,
                      itemLabel: (item) =>
                          "${item.brandName} - ${item.bottleSize} - ${item.labelType}",
                      isRequired: true,
                      onChanged: (v) => setState(() => selectedMapping = v),
                    ),

                    const SizedBox(height: 24), // 👈 match bottle
                    // ── Buttons ──
                    Row(
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
                            onPressed: state is LabelEntryLoading
                                ? null
                                : _submit,
                            child: state is LabelEntryLoading
                                ? const SizedBox(
                                    height: 18,
                                    width: 18,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                : const Text("SUBMIT"),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // ================= LIST =================
  Widget _listSection() {
    return BlocBuilder<LabelListBloc, LabelListState>(
      builder: (context, state) {
        if (state is LabelListLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is LabelListFailure) {
          return Center(
            child: Text(state.error, style: const TextStyle(color: Colors.red)),
          );
        }

        if (state is LabelListSuccess) {
          if (state.list.isEmpty) {
            return const Center(child: Text("No label entries found"));
          }

          return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.list.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              if (state.count == 10) {
                if (index == state.list.length - 1) {
                  return Column(
                    children: [
                      _LabelTile(
                        entry: state.list[index],
                        mappingList: _mappingList,
                      ),
                      const SizedBox(height: 12),
                      OutlinedButton(
                        style: ButtonStyle(
                          overlayColor: MaterialStateProperty.all(
                            AppColors.primary.withOpacity(0.1),
                          ),
                        ),
                        onPressed: () {
                          context.read<LabelListBloc>().add(
                            FetchLabelListEvent(
                              fromDate: formatDate(fromDate),
                              toDate: formatDate(toDate),
                              palletCode: palletSearch,
                              vehicleNo: vehicleSearch,
                              partyNameId: selectedPartyId,
                              brandId: selectedBrandId,
                              bottleSizeId: selectedSizeId,
                              orderBy: orderBy,
                              limit: state.count == 10
                                  ? state.count + 10
                                  : null, // load more if count is 10 (means there might be more)
                            ),
                          );
                        },
                        child: Text(
                          "Load More ",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ],
                  );
                }
              }
              return _LabelTile(
                entry: state.list[index],
                mappingList: _mappingList,
              );
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    if (selectedMapping == null) {
      snackbar(context, message: "Please select mapping label");
      return;
    }

    context.read<UnloadingBloc>().add(
      SubmitLabelEntry(
        palletCode: palletController.text.trim(),
        casesQuantity: int.parse(casesController.text.trim()),
        mappingLabel: selectedMapping!.id!,
        rollPerCase: int.parse(rollController.text.trim()),
        labelPerRoll: int.parse(labelController.text.trim()),
      ),
    );
  }

  void _refreshList(BuildContext context) {
    context.read<LabelListBloc>().add(
      FetchLabelListEvent(
        fromDate: formatDate(fromDate),
        toDate: formatDate(toDate),
      ),
    );
  }

  void _resetForm() {
    _formKey.currentState?.reset();
    palletController.clear();
    casesController.clear();
    rollController.clear();
    labelController.clear();
    selectedMapping = null;
    setState(() {});
  }

  Widget _field(String label, TextEditingController c) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextFormField(
        controller: c,
        validator: (v) => v == null || v.isEmpty ? "$label is required" : null,
        decoration: InputDecoration(labelText: label),
      ),
    );
  }

  Widget _numberField(String label, TextEditingController c) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextFormField(
        controller: c,
        keyboardType: TextInputType.number,
        validator: (v) {
          if (v == null || v.isEmpty) return "$label is required";
          if (int.tryParse(v) == null) return "Enter valid number";
          return null;
        },
        decoration: InputDecoration(labelText: label),
      ),
    );
  }
}

// ================= TILE =================
class _LabelTile extends StatelessWidget {
  final LabelUnloadingModel entry;
  final List<MappingLabelModel> mappingList;

  const _LabelTile({required this.entry, required this.mappingList});

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

        // 🔵 Leading (like bottle size)
        leading: CircleAvatar(
          backgroundColor: AppColors.primary.withOpacity(0.1),
          child: Text(
            "${entry.bottleSize ?? '-'}",
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        // 🔵 Title
        title: Text(
          entry.palletUniqueCode ?? "-",
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),

        // 🔵 Subtitle
        subtitle: Text(
          "${entry.brandName ?? "-"} • ${entry.date ?? "-"}",
          style: TextStyle(color: Colors.grey[600], fontSize: 12),
        ),

        // 🔵 Trailing (Available labels)
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
                "${entry.labelAvailable ?? 0} avail.",
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

          // 🔥 INFO GRID (like bottle)
          _infoGrid(),

          const SizedBox(height: 6),

          // 🔴 ACTION BUTTONS
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
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

  // ================= DELETE =================
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
                bloc.add(DeleteLabelEntry(id: id));
                Navigator.pop(context);
              },
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  // ================= UPDATE =================
  void _openUpdateSheet(BuildContext context, LabelUnloadingModel entry) {
    final palletController = TextEditingController(
      text: entry.palletUniqueCode ?? "",
    );
    final casesController = TextEditingController(
      text: entry.casesQuantity?.toString() ?? "",
    );
    final rollController = TextEditingController(
      text: entry.rollPerCase?.toString() ?? "",
    );
    final labelController = TextEditingController(
      text: entry.labelPerRoll?.toString() ?? "",
    );

    final bloc = context.read<UnloadingBloc>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (sheetContext) {
        MappingLabelModel? selectedMapping =
            mappingList.where((e) => e.id == entry.mappingLabel).isNotEmpty
            ? mappingList.firstWhere((e) => e.id == entry.mappingLabel)
            : null;

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
                      "Update Label Entry",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // 🔹 Pallet
                    TextField(
                      controller: palletController,
                      decoration: _input("Pallet Code"),
                    ),

                    const SizedBox(height: 10),

                    // 🔹 Cases
                    TextField(
                      controller: casesController,
                      keyboardType: TextInputType.number,
                      decoration: _input("Cases Quantity"),
                    ),

                    const SizedBox(height: 10),

                    // 🔹 Roll per case
                    TextField(
                      controller: rollController,
                      keyboardType: TextInputType.number,
                      decoration: _input("Roll per Case"),
                    ),

                    const SizedBox(height: 10),

                    // 🔹 Label per roll
                    TextField(
                      controller: labelController,
                      keyboardType: TextInputType.number,
                      decoration: _input("Label per Roll"),
                    ),

                    const SizedBox(height: 10),

                    // 🔥 Mapping Dropdown (same pattern as bottle)
                    AppDropdown<MappingLabelModel>(
                      title: "Mapping Label",
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
                          "${item.brandName} - ${item.bottleSize} - ${item.labelType}",
                      onChanged: (val) {
                        setModalState(() => selectedMapping = val);
                      },
                    ),

                    const SizedBox(height: 20),

                    // 🔴 UPDATE BUTTON
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (selectedMapping == null) {
                            snackbar(
                              context,
                              message: "Please select mapping label",
                            );
                            return;
                          }

                          bloc.add(
                            UpdateLabelEntry(
                              id: entry.id!,
                              palletCode: palletController.text.trim(),
                              casesQuantity: int.parse(
                                casesController.text.trim(),
                              ),
                              rollPerCase: int.parse(
                                rollController.text.trim(),
                              ),
                              labelPerRoll: int.parse(
                                labelController.text.trim(),
                              ),
                              mappingLabel: selectedMapping!.id!,
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

  InputDecoration _input(String label) {
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

  // ================= INFO GRID =================
  Widget _infoGrid() {
    final items = [
      _InfoItem("Date", entry.date ?? "-"),
      _InfoItem("Time", entry.time ?? "-"),
      _InfoItem("Gate ID", entry.gateId?.toString() ?? "-"),
      _InfoItem("Vehicle", entry.vehicleNo ?? "-"),
      _InfoItem("Party", entry.partyName ?? "-"),
      _InfoItem("Brand", entry.brandName ?? "-"),
      _InfoItem("Label Type", entry.labelType ?? "-"),
      _InfoItem("Bottle Size", "${entry.bottleSize ?? "-"} ml"),
      _InfoItem("Cases", entry.casesQuantity?.toString() ?? "-"),
      _InfoItem("Cases Avl.", entry.casesAvailable?.toString() ?? "-"),
      _InfoItem("Roll/Case", entry.rollPerCase?.toString() ?? "-"),
      _InfoItem("Roll Avl.", entry.rollAvailable?.toString() ?? "-"),
      _InfoItem("Label/Roll", entry.labelPerRoll?.toString() ?? "-"),
      _InfoItem("Label Avl.", entry.labelAvailable?.toString() ?? "-"),
      _InfoItem("Total Roll", entry.totalRoll?.toString() ?? "-"),
      _InfoItem("Total Label", entry.totalLabel?.toString() ?? "-"),
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

InputDecoration _input(String label, {String? hint}) {
  return InputDecoration(
    labelText: label,
    hintText: hint,
    filled: true,
    fillColor: Colors.grey.shade100,

    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),

    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),

    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),

    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        color: AppColors.primary.withOpacity(0.6),
        width: 1.2,
      ),
    ),

    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Colors.red),
    ),

    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Colors.red, width: 1.2),
    ),

    labelStyle: TextStyle(fontSize: 13, color: Colors.grey[700]),

    hintStyle: TextStyle(fontSize: 13, color: Colors.grey[500]),
  );
}
