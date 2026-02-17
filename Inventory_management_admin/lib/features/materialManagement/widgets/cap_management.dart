import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:inventory_management_admin_pannel/core/Utils/snack_bar.dart';
import 'package:inventory_management_admin_pannel/features/materialManagement/bloc/material_management_bloc.dart';
import 'package:inventory_management_admin_pannel/features/materialManagement/bloc/material_management_event.dart';
import 'package:inventory_management_admin_pannel/features/materialManagement/bloc/material_management_state.dart';

class CapManagementWidget extends StatelessWidget {
  const CapManagementWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _card(title: "Create Cap", child: const CreateCap()),
        const SizedBox(height: 24),
        _card(title: "Update Cap", child: const UpdateCap()),
        const SizedBox(height: 24),
        _card(title: "Delete Cap", child: const DeleteCap()),
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
/// CREATE CAP
////////////////////////////////////////////////////////////

class CreateCap extends StatefulWidget {
  const CreateCap({super.key});

  @override
  State<CreateCap> createState() => _CreateCapState();
}

class _CreateCapState extends State<CreateCap> {
  final _formKey = GlobalKey<FormState>();

  final sizeController = TextEditingController();
  final partyController = TextEditingController();
  final totalPerCaseController = TextEditingController();

  String? selectedStatus;
  String? selectedType;

  final statusOptions = ["Available", "Used", "Damaged"];
  final typeOptions = ["Plastic", "Metal", "Aluminium"];

  @override
  Widget build(BuildContext context) {
    return BlocListener<MaterialManagementBloc, MaterialManagementState>(
      listener: (context, state) {
        if (state is CreateCapEntrySuccess) {
          snackbar(
            context,
            message: state.message,
            color: Colors.green,
            title: "Success",
          );
          _formKey.currentState!.reset();
          setState(() {
            selectedStatus = null;
            selectedType = null;
            sizeController.clear();
            partyController.clear();
            totalPerCaseController.clear();
          });
        }

        if (state is CreateCapEntryFailure) {
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
                  child: _numField(
                    sizeController,
                    "Size",
                    validator: _requiredNumberValidator,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: _textField(
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
                  child: _numField(
                    totalPerCaseController,
                    "Total Cap Per Case",
                    validator: _requiredNumberValidator,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: _dropdownField(
                    "Cap Status",
                    statusOptions,
                    selectedStatus,
                    (val) => setState(() => selectedStatus = val),
                    validator: (val) =>
                        val == null ? "Select Cap Status" : null,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _dropdownField(
                    "Cap Type",
                    typeOptions,
                    selectedType,
                    (val) => setState(() => selectedType = val),
                    validator: (val) => val == null ? "Select Cap Type" : null,
                  ),
                ),
                const SizedBox(width: 20),
                BlocBuilder<MaterialManagementBloc, MaterialManagementState>(
                  builder: (context, state) {
                    return FilledButton(
                      onPressed: state is CreateCapEntryLoading
                          ? null
                          : () {
                              if (!_formKey.currentState!.validate()) return;

                              context.read<MaterialManagementBloc>().add(
                                CreateCapEntryEvent(
                                  size: int.parse(sizeController.text.trim()),
                                  partyName: partyController.text.trim(),
                                  totalCapPerCase: int.parse(
                                    totalPerCaseController.text.trim(),
                                  ),
                                  capStatus: selectedStatus!,
                                  capType: selectedType!,
                                ),
                              );
                            },
                      child: state is CreateCapEntryLoading
                          ? const SizedBox(
                              height: 16,
                              width: 16,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Text("Create Cap"),
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
/// UPDATE CAP
////////////////////////////////////////////////////////////

class UpdateCap extends StatefulWidget {
  const UpdateCap({super.key});

  @override
  State<UpdateCap> createState() => _UpdateCapState();
}

class _UpdateCapState extends State<UpdateCap> {
  final _formKey = GlobalKey<FormState>();

  final idController = TextEditingController();
  final sizeController = TextEditingController();
  final partyController = TextEditingController();
  final totalPerCaseController = TextEditingController();

  String? selectedStatus;
  String? selectedType;

  final statusOptions = ["Available", "Used", "Damaged"];
  final typeOptions = ["Plastic", "Metal", "Aluminium"];

  @override
  Widget build(BuildContext context) {
    return BlocListener<MaterialManagementBloc, MaterialManagementState>(
      listener: (context, state) {
        if (state is UpdateCapEntrySuccess) {
          snackbar(
            context,
            message: state.message,
            color: Colors.green,
            title: "Success",
          );

          _formKey.currentState!.reset();
          setState(() {
            selectedStatus = null;
            selectedType = null;
            idController.clear();
            sizeController.clear();
            partyController.clear();
            totalPerCaseController.clear();
          });
        }

        if (state is UpdateCapEntryFailure) {
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
                  child: _numField(
                    idController,
                    "Cap ID",
                    validator: _requiredNumberValidator,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: _numField(
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
                  child: _textField(
                    partyController,
                    "Party Name",
                    validator: _requiredValidator,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: _numField(
                    totalPerCaseController,
                    "Total Cap Per Case",
                    validator: _requiredNumberValidator,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _dropdownField(
                    "Cap Status",
                    statusOptions,
                    selectedStatus,
                    (val) => setState(() => selectedStatus = val),
                    validator: (val) =>
                        val == null ? "Select Cap Status" : null,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: _dropdownField(
                    "Cap Type",
                    typeOptions,
                    selectedType,
                    (val) => setState(() => selectedType = val),
                    validator: (val) => val == null ? "Select Cap Type" : null,
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
                        onPressed: state is UpdateCapEntryLoading
                            ? null
                            : () {
                                if (!_formKey.currentState!.validate()) return;

                                context.read<MaterialManagementBloc>().add(
                                  UpdateCapEntryEvent(
                                    updateId: int.parse(
                                      idController.text.trim(),
                                    ),
                                    size: int.parse(sizeController.text.trim()),
                                    partyName: partyController.text.trim(),
                                    totalCapPerCase: int.parse(
                                      totalPerCaseController.text.trim(),
                                    ),
                                    capStatus: selectedStatus!,
                                    capType: selectedType!,
                                  ),
                                );
                              },
                        child: state is UpdateCapEntryLoading
                            ? const SizedBox(
                                height: 18,
                                width: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Text("Update Cap"),
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
/// DELETE CAP
////////////////////////////////////////////////////////////

class DeleteCap extends StatefulWidget {
  const DeleteCap({super.key});

  @override
  State<DeleteCap> createState() => _DeleteCapState();
}

class _DeleteCapState extends State<DeleteCap> {
  final _formKey = GlobalKey<FormState>();
  final idController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<MaterialManagementBloc, MaterialManagementState>(
      listener: (context, state) {
        if (state is DeleteCapEntrySuccessState) {
          snackbar(
            context,
            message: state.message,
            color: Colors.green,
            title: "Success",
          );

          idController.clear();
        }

        if (state is DeleteCapFailureState) {
          snackbar(context, message: state.error);
          context.pop();
        }
      },
      child: Form(
        key: _formKey,
        child: Row(
          children: [
            Expanded(
              child: _numField(
                idController,
                "Cap ID",
                validator: _requiredNumberValidator,
              ),
            ),
            const SizedBox(width: 20),
            BlocBuilder<MaterialManagementBloc, MaterialManagementState>(
              builder: (context, state) {
                final isLoading = state is DeleteCapLoadingState;

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
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.red,
                          ),
                        )
                      : const Text(
                          "Delete Cap",
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
        content: const Text("Are you sure you want to delete this cap?"),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              context.pop();

              context.read<MaterialManagementBloc>().add(
                DeleteCapEntryEvent(
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

Widget _textField(
  TextEditingController controller,
  String label, {
  String? Function(String?)? validator,
}) {
  return TextFormField(
    controller: controller,
    validator: validator,
    decoration: InputDecoration(
      labelText: label,
      border: const OutlineInputBorder(),
    ),
  );
}

Widget _numField(
  TextEditingController controller,
  String label, {
  String? Function(String?)? validator,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: TextInputType.number,
    validator: validator,
    decoration: InputDecoration(
      labelText: label,
      border: const OutlineInputBorder(),
    ),
  );
}

Widget _dropdownField(
  String label,
  List<String> items,
  String? value,
  Function(String?) onChanged, {
  String? Function(String?)? validator,
}) {
  return DropdownButtonFormField<String>(
    value: value,
    validator: validator,
    decoration: InputDecoration(
      labelText: label,
      border: const OutlineInputBorder(),
    ),
    items: items
        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
        .toList(),
    onChanged: onChanged,
  );
}

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
