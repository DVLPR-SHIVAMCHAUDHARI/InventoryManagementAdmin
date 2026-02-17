import 'package:inventory_management_admin_pannel/core/Utils/snack_bar.dart';
import 'package:inventory_management_admin_pannel/core/widgets/appdropdown.dart';
import 'package:inventory_management_admin_pannel/features/master_api/department/bloc/department_bloc.dart';
import 'package:inventory_management_admin_pannel/features/master_api/department/bloc/department_event.dart';
import 'package:inventory_management_admin_pannel/features/master_api/department/bloc/department_state.dart';
import 'package:inventory_management_admin_pannel/features/master_api/models/department_model.dart';
import 'package:inventory_management_admin_pannel/features/master_api/models/party_model.dart';
import 'package:inventory_management_admin_pannel/features/master_api/parties/bloc/parties_bloc.dart';
import 'package:inventory_management_admin_pannel/features/master_api/parties/bloc/parties_event.dart';
import 'package:inventory_management_admin_pannel/features/master_api/parties/bloc/parties_state.dart';
import 'package:inventory_management_admin_pannel/features/master_api/repositories/masterrepo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class PartyManagementScreen extends StatefulWidget {
  const PartyManagementScreen({super.key});

  @override
  State<PartyManagementScreen> createState() => _PartyManagementScreenState();
}

class _PartyManagementScreenState extends State<PartyManagementScreen> {
  /// TABLE CONTROLS
  int currentPage = 1;
  int pageSize = 10;
  int totalCount = 0;

  /// CONTROLLERS
  ///

  final TextEditingController createPartyNameController =
      TextEditingController();
  final TextEditingController createAddressController = TextEditingController();

  final TextEditingController updateIdController = TextEditingController();
  final TextEditingController updatePartyNameController =
      TextEditingController();
  final TextEditingController updateAddressController = TextEditingController();

  final TextEditingController deleteIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => PartyBloc(MasterRepo())..add(const FetchParties()),
        ),
        BlocProvider(
          create: (context) =>
              DepartmentBloc(MasterRepo())..add(FetchDepartments()),
        ),
      ],
      child: BlocListener<PartyBloc, PartyState>(
        listener: (context, state) {
          /// CREATE
          if (state is CreatePartySuccess) {
            snackbar(
              context,
              message: state.message,
              title: "Great",
              color: Colors.green,
            );
            createPartyNameController.clear();
            createAddressController.clear();
          }

          if (state is CreatePartyFailure) {
            snackbar(
              context,
              message: state.error,
              title: "Oops",
              color: Colors.red,
            );
          }

          /// UPDATE
          if (state is UpdatePartySuccess) {
            snackbar(
              context,
              message: state.message,
              title: "Great",
              color: Colors.green,
            );
            updateIdController.clear();
            updatePartyNameController.clear();
            updateAddressController.clear();
          }

          if (state is UpdatePartyFailure) {
            snackbar(
              context,
              message: state.error,
              title: "Oops",
              color: Colors.red,
            );
          }

          /// DELETE
          if (state is DeletePartySuccess) {
            snackbar(
              context,
              message: state.message,
              title: "Great",
              color: Colors.green,
            );
            deleteIdController.clear();
          }

          if (state is DeletePartyFailure) {
            snackbar(
              context,
              message: state.error,
              title: "Oops",
              color: Colors.red,
            );
          }
        },
        child: Scaffold(
          backgroundColor: const Color(0xFFF5F7FB),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// TITLE
                Text(
                  "Party Management",
                  style: TextStyle(
                    fontSize: width * 0.018,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                const Divider(),
                const SizedBox(height: 24),

                /// CREATE
                _buildCard(
                  title: "Create Party",
                  child: _CreatePartyForm(
                    partyController: createPartyNameController,
                    addressController: createAddressController,
                  ),
                ),

                const SizedBox(height: 24),

                /// UPDATE
                _buildCard(
                  title: "Update Party",
                  child: _UpdatePartyForm(
                    idController: updateIdController,
                    partyController: updatePartyNameController,
                    addressController: updateAddressController,
                  ),
                ),

                const SizedBox(height: 24),

                /// DELETE
                _buildCard(
                  title: "Delete Party",
                  child: _DeletePartyForm(idController: deleteIdController),
                ),

                const SizedBox(height: 30),

                /// TABLE
                _buildCard(
                  title: "Party List",
                  child: Column(
                    children: [
                      BlocBuilder<PartyBloc, PartyState>(
                        builder: (context, state) {
                          if (state is PartyLoading) {
                            return Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                              child: Container(
                                height: 200,
                                width: double.infinity,
                                color: Colors.white,
                              ),
                            );
                          }

                          if (state is PartyLoaded) {
                            totalCount = state.parties.length;
                            return _buildTable(state.parties);
                          }

                          if (state is PartyError) {
                            return Text(
                              state.message,
                              style: const TextStyle(color: Colors.red),
                            );
                          }

                          return const SizedBox.shrink();
                        },
                      ),
                      const SizedBox(height: 12),
                      _buildPagination(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTable(List<PartyModel> parties) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        headingRowColor: WidgetStatePropertyAll(Colors.grey.shade100),
        columns: const [
          DataColumn(label: Text("ID")),
          DataColumn(label: Text("Party Name")),
          DataColumn(label: Text("Address")),
          DataColumn(label: Text("Location")),
        ],
        rows: parties.map((p) {
          return DataRow(
            cells: [
              DataCell(Text(p.id?.toString() ?? "-")),
              DataCell(Text(p.name ?? "-")),
              DataCell(Text(p.companyAddress ?? "-")),
              DataCell(Text(p.department?.toString() ?? "-")),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildPagination() {
    final totalPages = (totalCount / pageSize).ceil().clamp(1, 999);

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text("Page $currentPage of $totalPages"),
        IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: currentPage > 1
              ? () => setState(() => currentPage--)
              : null,
        ),
        IconButton(
          icon: const Icon(Icons.chevron_right),
          onPressed: currentPage < totalPages
              ? () => setState(() => currentPage++)
              : null,
        ),
      ],
    );
  }

  Widget _buildCard({required String title, required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(blurRadius: 8, color: Colors.black12)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}

/// =======================
/// FORMS
/// =======================
/// =======================

class _CreatePartyForm extends StatefulWidget {
  final TextEditingController partyController;
  final TextEditingController addressController;

  _CreatePartyForm({
    required this.partyController,
    required this.addressController,
  });

  @override
  State<_CreatePartyForm> createState() => _CreatePartyFormState();
}

class _CreatePartyFormState extends State<_CreatePartyForm> {
  DepartmentModel? _selectedDepartment;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _field(widget.partyController, "Party Name"),
        const SizedBox(width: 12),

        _field(widget.addressController, "Address"),
        const SizedBox(width: 12),

        /// ✅ Department Dropdown
        BlocBuilder<DepartmentBloc, DepartmentState>(
          builder: (context, state) {
            if (state is DepartmentLoading) {
              return AppDropdownShimmer(title: "Department");
            }

            if (state is DepartmentLoaded) {
              return Expanded(
                child: NoLabelDropdown<DepartmentModel>(
                  borderrequired: true,
                  hint: "Select Department",
                  items: state.departments,
                  value: _selectedDepartment,
                  itemLabel: (d) => d.name,
                  onChanged: (v) {
                    setState(() => _selectedDepartment = v);
                  },
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),

        const SizedBox(width: 12),

        /// CREATE BUTTON
        ElevatedButton(
          onPressed: () {
            if (widget.partyController.text.isEmpty ||
                widget.addressController.text.isEmpty ||
                _selectedDepartment == null) {
              snackbar(
                context,
                title: "Error",
                message: "Please fill all fields",
                color: Colors.red,
              );
              return;
            }

            context.read<PartyBloc>().add(
              CreateParty(
                partyName: widget.partyController.text.trim(),
                companyAddress: widget.addressController.text.trim(),
                departmentLocation: _selectedDepartment!.id!,
              ),
            );
          },
          child: const Text("Create"),
        ),
      ],
    );
  }
}

class _UpdatePartyForm extends StatefulWidget {
  final TextEditingController idController;
  final TextEditingController partyController;
  final TextEditingController addressController;

  const _UpdatePartyForm({
    required this.idController,
    required this.partyController,
    required this.addressController,
  });

  @override
  State<_UpdatePartyForm> createState() => _UpdatePartyFormState();
}

class _UpdatePartyFormState extends State<_UpdatePartyForm> {
  DepartmentModel? _selectedDepartment;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _numField(widget.idController, "ID"),
        const SizedBox(width: 12),

        _field(widget.partyController, "Party Name"),
        const SizedBox(width: 12),

        _field(widget.addressController, "Address"),
        const SizedBox(width: 12),

        /// ✅ Department Dropdown (replacing box location)
        BlocBuilder<DepartmentBloc, DepartmentState>(
          builder: (context, state) {
            if (state is DepartmentLoading) {
              return AppDropdownShimmer(title: "Department");
            }

            if (state is DepartmentLoaded) {
              return Expanded(
                child: NoLabelDropdown<DepartmentModel>(
                  borderrequired: true,
                  hint: "Select Department",
                  items: state.departments,
                  value: _selectedDepartment,
                  itemLabel: (d) => d.name,
                  onChanged: (v) {
                    setState(() => _selectedDepartment = v);
                  },
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),

        const SizedBox(width: 12),

        /// UPDATE BUTTON
        ElevatedButton(
          onPressed: () {
            if (widget.idController.text.isEmpty ||
                widget.partyController.text.isEmpty ||
                widget.addressController.text.isEmpty ||
                _selectedDepartment == null) {
              snackbar(
                context,
                title: "Error",
                message: "Please fill all fields",
                color: Colors.red,
              );
              return;
            }

            context.read<PartyBloc>().add(
              UpdateParty(
                id: int.parse(widget.idController.text),
                partyName: widget.partyController.text.trim(),
                companyAddress: widget.addressController.text.trim(),
                boxLocation: _selectedDepartment!.id!,
              ),
            );
          },
          child: const Text("Update"),
        ),
      ],
    );
  }
}

class _DeletePartyForm extends StatelessWidget {
  final TextEditingController idController;

  const _DeletePartyForm({required this.idController});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _numField(idController, "ID"),
        const SizedBox(width: 12),
        ElevatedButton(
          onPressed: () {
            if (idController.text.isEmpty) return;

            context.read<PartyBloc>().add(
              DeleteParty(id: int.parse(idController.text)),
            );
          },
          child: const Text("Delete", style: TextStyle(color: Colors.red)),
        ),
      ],
    );
  }
}

Widget _field(TextEditingController c, String label) {
  return Expanded(
    child: TextField(
      controller: c,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    ),
  );
}

Widget _numField(TextEditingController c, String label) {
  return Expanded(
    child: TextField(
      controller: c,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    ),
  );
}
