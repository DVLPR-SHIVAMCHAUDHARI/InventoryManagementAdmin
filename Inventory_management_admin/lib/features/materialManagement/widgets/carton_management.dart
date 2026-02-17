import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_management_admin_pannel/core/Utils/snack_bar.dart';
import 'package:inventory_management_admin_pannel/features/materialManagement/bloc/material_management_bloc.dart';
import 'package:inventory_management_admin_pannel/features/materialManagement/bloc/material_management_event.dart';
import 'package:inventory_management_admin_pannel/features/materialManagement/bloc/material_management_state.dart';
import 'package:inventory_management_admin_pannel/features/materialManagement/widgets/helper_class.dart';

class CartonManagementWidget extends StatelessWidget {
  const CartonManagementWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _card(title: "Create Carton", child: const CreateCarton()),
        const SizedBox(height: 24),
        _card(title: "Update Carton", child: const UpdateCarton()),
        const SizedBox(height: 24),
        _card(title: "Delete Carton", child: const DeleteCarton()),
      ],
    );
  }

  Widget _card({required String title, required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(blurRadius: 8, color: Colors.black12, offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          child,
        ],
      ),
    );
  }
}

////////////////////////////////////////////////////////////
/// CREATE CARTON
////////////////////////////////////////////////////////////

class CreateCarton extends StatefulWidget {
  const CreateCarton({super.key});

  @override
  State<CreateCarton> createState() => _CreateCartonState();
}

class _CreateCartonState extends State<CreateCarton> {
  final _formKey = GlobalKey<FormState>();

  final sizeController = TextEditingController();
  final partyController = TextEditingController();
  final totalPerCaseController = TextEditingController();

  String? selectedStatus;
  String? selectedType;

  final statusOptions = ["Available", "Packed", "Damaged"];
  final typeOptions = ["Corrugated", "Duplex", "Heavy Duty"];

  @override
  Widget build(BuildContext context) {
    return BlocListener<MaterialManagementBloc, MaterialManagementState>(
      listener: (context, state) {
        if (state is CreateCartonEntrySuccess) {
          snackbar(
            context,
            message: state.message,
            color: Colors.green,
            title: "Success",
          );

          _formKey.currentState!.reset();
          sizeController.clear();
          partyController.clear();
          totalPerCaseController.clear();
          setState(() {
            selectedStatus = null;
            selectedType = null;
          });
        }

        if (state is CreateCartonEntryFailure) {
          snackbar(context, message: state.error);
        }
      },
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: numField(
                    sizeController,
                    "Size",
                    validator: _requiredNumberValidator,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: textField(
                    partyController,
                    "Party Name",
                    validator: _requiredValidator,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: numField(
                    totalPerCaseController,
                    "Total Carton Per Case",
                    validator: _requiredNumberValidator,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: dropdownField(
                    "Carton Status",
                    statusOptions,
                    selectedStatus,
                    (val) => setState(() => selectedStatus = val),
                    validator: (val) =>
                        val == null ? "Select Carton Status" : null,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: dropdownField(
                    "Carton Type",
                    typeOptions,
                    selectedType,
                    (val) => setState(() => selectedType = val),
                    validator: (val) =>
                        val == null ? "Select Carton Type" : null,
                  ),
                ),
                const SizedBox(width: 20),
                BlocBuilder<MaterialManagementBloc, MaterialManagementState>(
                  builder: (context, state) {
                    return FilledButton(
                      onPressed: state is CreateCartonEntryLoading
                          ? null
                          : () {
                              if (!_formKey.currentState!.validate()) return;

                              context.read<MaterialManagementBloc>().add(
                                CreateCartonEntryEvent(
                                  size: int.parse(sizeController.text.trim()),
                                  partyName: partyController.text.trim(),
                                  totalCartonPerCase: int.parse(
                                    totalPerCaseController.text.trim(),
                                  ),
                                  cartonStatus: selectedStatus!,
                                  cartonType: selectedType!,
                                ),
                              );
                            },
                      child: state is CreateCartonEntryLoading
                          ? const SizedBox(
                              height: 18,
                              width: 18,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Text("Create Carton"),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

////////////////////////////////////////////////////////////
/// UPDATE CARTON
////////////////////////////////////////////////////////////

class UpdateCarton extends StatefulWidget {
  const UpdateCarton({super.key});

  @override
  State<UpdateCarton> createState() => _UpdateCartonState();
}

class _UpdateCartonState extends State<UpdateCarton> {
  final _formKey = GlobalKey<FormState>();

  final idController = TextEditingController();
  final sizeController = TextEditingController();
  final partyController = TextEditingController();
  final totalPerCaseController = TextEditingController();

  String? selectedStatus;
  String? selectedType;

  final statusOptions = ["Available", "Packed", "Damaged"];
  final typeOptions = ["Corrugated", "Duplex", "Heavy Duty"];

  @override
  Widget build(BuildContext context) {
    return BlocListener<MaterialManagementBloc, MaterialManagementState>(
      listener: (context, state) {
        if (state is UpdateCartonEntrySuccess) {
          snackbar(
            context,
            message: state.message,
            color: Colors.green,
            title: "Success",
          );

          _formKey.currentState!.reset();
          idController.clear();
          sizeController.clear();
          partyController.clear();
          totalPerCaseController.clear();
          setState(() {
            selectedStatus = null;
            selectedType = null;
          });
        }

        if (state is UpdateCartonEntryFailure) {
          snackbar(context, message: state.error);
        }
      },
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: numField(
                    idController,
                    "Carton ID",
                    validator: _requiredNumberValidator,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: numField(
                    sizeController,
                    "Size",
                    validator: _requiredNumberValidator,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: textField(
                    partyController,
                    "Party Name",
                    validator: _requiredValidator,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: numField(
                    totalPerCaseController,
                    "Total Carton Per Case",
                    validator: _requiredNumberValidator,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: dropdownField(
                    "Carton Status",
                    statusOptions,
                    selectedStatus,
                    (val) => setState(() => selectedStatus = val),
                    validator: (val) =>
                        val == null ? "Select Carton Status" : null,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: dropdownField(
                    "Carton Type",
                    typeOptions,
                    selectedType,
                    (val) => setState(() => selectedType = val),
                    validator: (val) =>
                        val == null ? "Select Carton Type" : null,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Align(
              alignment: Alignment.centerRight,
              child:
                  BlocBuilder<MaterialManagementBloc, MaterialManagementState>(
                    builder: (context, state) {
                      return FilledButton(
                        onPressed: state is UpdateCartonEntryLoading
                            ? null
                            : () {
                                if (!_formKey.currentState!.validate()) return;

                                context.read<MaterialManagementBloc>().add(
                                  UpdateCartonEntryEvent(
                                    updateId: int.parse(
                                      idController.text.trim(),
                                    ),
                                    size: int.parse(sizeController.text.trim()),
                                    partyName: partyController.text.trim(),
                                    totalCartonPerCase: int.parse(
                                      totalPerCaseController.text.trim(),
                                    ),
                                    cartonStatus: selectedStatus!,
                                    cartonType: selectedType!,
                                  ),
                                );
                              },
                        child: state is UpdateCartonEntryLoading
                            ? const SizedBox(
                                height: 18,
                                width: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text("Update Carton"),
                      );
                    },
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

////////////////////////////////////////////////////////////
/// DELETE CARTON
////////////////////////////////////////////////////////////

class DeleteCarton extends StatefulWidget {
  const DeleteCarton({super.key});

  @override
  State<DeleteCarton> createState() => _DeleteCartonState();
}

class _DeleteCartonState extends State<DeleteCarton> {
  final _formKey = GlobalKey<FormState>();
  final idController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<MaterialManagementBloc, MaterialManagementState>(
      listener: (context, state) {
        if (state is DeleteCartonEntrySuccessState) {
          snackbar(
            context,
            message: state.message,
            color: Colors.green,
            title: "Success",
          );

          idController.clear();
        }

        if (state is DeleteCartonFailureState) {
          snackbar(context, message: state.error);
        }
      },
      child: Form(
        key: _formKey,
        child: Row(
          children: [
            Expanded(
              child: numField(
                idController,
                "Carton ID",
                validator: _requiredNumberValidator,
              ),
            ),
            const SizedBox(width: 20),
            BlocBuilder<MaterialManagementBloc, MaterialManagementState>(
              builder: (context, state) {
                final isLoading = state is DeleteCartonLoadingState;

                return ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : () {
                          if (!_formKey.currentState!.validate()) return;
                          _showDeleteDialog(context);
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade100,
                  ),
                  child: isLoading
                      ? const SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text(
                          "Delete Carton",
                          style: TextStyle(color: Colors.red),
                        ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Confirm Delete"),
        content: const Text("Are you sure you want to delete this carton?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog safely

              context.read<MaterialManagementBloc>().add(
                DeleteCartonEntryEvent(
                  deleteId: int.parse(idController.text.trim()),
                ),
              );
            },
            child: const Text("Delete"),
          ),
        ],
      ),
    );
  }
}

////////////////////////////////////////////////////////////
/// VALIDATORS
////////////////////////////////////////////////////////////

String? _requiredValidator(String? value) {
  if (value == null || value.trim().isEmpty) {
    return "This field is required";
  }
  return null;
}

String? _requiredNumberValidator(String? value) {
  if (value == null || value.trim().isEmpty) {
    return "This field is required";
  }
  if (int.tryParse(value) == null) {
    return "Enter a valid number";
  }
  return null;
}
