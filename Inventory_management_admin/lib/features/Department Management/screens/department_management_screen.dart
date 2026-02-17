import 'package:inventory_management_admin_pannel/core/Utils/colorpallate.dart';
import 'package:inventory_management_admin_pannel/core/Utils/snack_bar.dart';
import 'package:inventory_management_admin_pannel/features/master_api/department/bloc/department_bloc.dart';
import 'package:inventory_management_admin_pannel/features/master_api/department/bloc/department_event.dart';
import 'package:inventory_management_admin_pannel/features/master_api/department/bloc/department_state.dart';
import 'package:inventory_management_admin_pannel/features/master_api/models/department_model.dart';
import 'package:inventory_management_admin_pannel/features/master_api/repositories/masterrepo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class DepartmentManagementScreen extends StatefulWidget {
  const DepartmentManagementScreen({super.key});

  @override
  State<DepartmentManagementScreen> createState() =>
      _DepartmentManagementScreenState();
}

class _DepartmentManagementScreenState
    extends State<DepartmentManagementScreen> {
  /// TABLE CONTROLS
  int currentPage = 1;
  int pageSize = 10;
  int totalCount = 0;
  final TextEditingController createDeptController = TextEditingController();
  final TextEditingController updateDeptIdController = TextEditingController();
  final TextEditingController updateDeptNameController =
      TextEditingController();
  final TextEditingController deleteDeptIdController = TextEditingController();

  final List<int> pageSizeOptions = [10, 25, 50];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (_) =>
          DepartmentBloc(MasterRepo())..add(const FetchDepartments()),
      child: BlocListener<DepartmentBloc, DepartmentState>(
        listener: (context, state) {
          /// =======================
          /// CREATE
          /// =======================
          if (state is CreateDepartmentSuccess) {
            snackbar(
              context,
              message: state.message,
              title: 'Great',
              color: Colors.green,
            );
            createDeptController.clear();
          }

          if (state is CreateDepartmentFailure) {
            snackbar(
              context,
              message: state.error,
              title: 'Oops',
              color: Colors.red,
            );
          }

          /// =======================
          /// UPDATE
          /// =======================
          if (state is UpdateDepartmentSuccess) {
            snackbar(
              context,
              message: state.message,
              title: 'Great',
              color: Colors.green,
            );
            updateDeptIdController.clear();
            updateDeptNameController.clear();
          }

          if (state is UpdateDepartmentFailure) {
            snackbar(
              context,
              message: state.error,
              title: 'Oops',
              color: Colors.red,
            );
          }

          /// =======================
          /// DELETE
          /// =======================
          if (state is DeleteDepartmentSuccess) {
            snackbar(
              context,
              message: state.message,
              title: 'Great',
              color: Colors.green,
            );
            deleteDeptIdController.clear();
          }

          if (state is DeleteDepartmentFailure) {
            snackbar(
              context,
              message: state.error,
              title: 'Oops',
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
                  "Department Management",
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
                  title: "Create Department",
                  child: _CreateDepartmentForm(
                    controller: createDeptController,
                  ),
                ),

                const SizedBox(height: 24),

                /// UPDATE
                _buildCard(
                  title: "Update Department",
                  child: _UpdateDepartmentForm(
                    idController: updateDeptIdController,
                    nameController: updateDeptNameController,
                  ),
                ),

                const SizedBox(height: 24),

                /// DELETE
                _buildCard(
                  title: "Delete Department",
                  child: _DeleteDepartmentForm(
                    idController: deleteDeptIdController,
                  ),
                ),

                const SizedBox(height: 30),

                /// TABLE
                _buildCard(
                  title: "Department List",
                  child: Column(
                    children: [
                      BlocBuilder<DepartmentBloc, DepartmentState>(
                        builder: (context, state) {
                          if (state is DepartmentLoading) {
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

                          if (state is DepartmentLoaded) {
                            totalCount = state.departments.length;
                            return _buildTable(departments: state.departments);
                          }

                          if (state is DepartmentError) {
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

  /// TABLE
  Widget _buildTable({required List<DepartmentModel> departments}) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DepartmentListTable(departments: departments),
    );
  }

  /// PAGINATION
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

  /// CARD
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
/// TABLE
/// =======================

class DepartmentListTable extends StatelessWidget {
  final List<DepartmentModel> departments;

  const DepartmentListTable({super.key, required this.departments});

  @override
  Widget build(BuildContext context) {
    return DataTable(
      headingRowColor: WidgetStatePropertyAll(Colors.grey.shade100),
      columns: const [
        DataColumn(label: Text("ID")),
        DataColumn(label: Text("Name")),
        DataColumn(label: Text("Status")),
        DataColumn(label: Text("Created At")),
        DataColumn(label: Text("Created By")),
        DataColumn(label: Text("Updated At")),
        DataColumn(label: Text("Updated By")),
      ],
      rows: departments.map((dept) {
        return DataRow(
          cells: [
            DataCell(Text(dept.id.toString())),
            DataCell(Text(dept.name)),
            DataCell(
              Text(
                dept.isDeleted == 1 ? "Deleted" : "Active",
                style: TextStyle(
                  color: dept.isDeleted == 1 ? Colors.red : Colors.green,
                ),
              ),
            ),
            DataCell(Text(DateFormat('dd MMM yyyy').format(dept.createdAt))),
            DataCell(Text(dept.createdByName)),
            DataCell(Text(DateFormat('dd MMM yyyy').format(dept.updatedAt))),
            DataCell(Text(dept.updatedByName ?? "-")),
          ],
        );
      }).toList(),
    );
  }
}

/// =======================
/// FORMS (BASIC PLACEHOLDERS)
/// =======================

class _CreateDepartmentForm extends StatelessWidget {
  final TextEditingController controller;

  const _CreateDepartmentForm({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            decoration: const InputDecoration(
              labelText: "Department Name",
              border: OutlineInputBorder(),
            ),
          ),
        ),
        const SizedBox(width: 12),
        ElevatedButton(
          onPressed: () {
            if (controller.text.trim().isEmpty) return;

            context.read<DepartmentBloc>().add(
              CreateDepartment(departmentName: controller.text.trim()),
            );
          },
          child: const Text("Create"),
        ),
      ],
    );
  }
}

class _UpdateDepartmentForm extends StatelessWidget {
  final TextEditingController idController;
  final TextEditingController nameController;

  const _UpdateDepartmentForm({
    required this.idController,
    required this.nameController,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: idController,
            decoration: const InputDecoration(
              labelText: "Department ID",
              border: OutlineInputBorder(),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: TextField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: "New Department Name",
              border: OutlineInputBorder(),
            ),
          ),
        ),
        const SizedBox(width: 12),
        ElevatedButton(
          onPressed: () {
            if (idController.text.isEmpty || nameController.text.isEmpty)
              return;

            context.read<DepartmentBloc>().add(
              UpdateDepartment(
                departmentId: idController.text.trim(),
                departmentName: nameController.text.trim(),
              ),
            );
          },
          child: const Text("Update"),
        ),
      ],
    );
  }
}

class _DeleteDepartmentForm extends StatelessWidget {
  final TextEditingController idController;

  const _DeleteDepartmentForm({required this.idController});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: idController,
            decoration: const InputDecoration(
              labelText: "Department ID",
              border: OutlineInputBorder(),
            ),
          ),
        ),
        const SizedBox(width: 12),
        ElevatedButton(
          onPressed: () {
            if (idController.text.isEmpty) return;

            context.read<DepartmentBloc>().add(
              DeleteDepartment(departmentId: idController.text.trim()),
            );
          },
          child: const Text("Delete", style: TextStyle(color: Colors.red)),
        ),
      ],
    );
  }
}
