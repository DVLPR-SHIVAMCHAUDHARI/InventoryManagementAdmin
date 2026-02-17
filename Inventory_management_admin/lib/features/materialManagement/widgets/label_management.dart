import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:inventory_management_admin_pannel/core/Utils/snack_bar.dart';
import 'package:inventory_management_admin_pannel/features/materialManagement/bloc/material_management_bloc.dart';
import 'package:inventory_management_admin_pannel/features/materialManagement/bloc/material_management_event.dart';
import 'package:inventory_management_admin_pannel/features/materialManagement/bloc/material_management_state.dart';
import 'package:inventory_management_admin_pannel/features/materialManagement/widgets/helper_class.dart';

class LabelManagementWidget extends StatelessWidget {
  const LabelManagementWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _card(title: "Create Label", child: const CreateLabel()),
        const SizedBox(height: 24),
        _card(title: "Update Label", child: const UpdateLabel()),
        const SizedBox(height: 24),
        _card(title: "Delete Label", child: const DeleteLabel()),
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
/// CREATE LABEL
////////////////////////////////////////////////////////////

class CreateLabel extends StatefulWidget {
  const CreateLabel({super.key});

  @override
  State<CreateLabel> createState() => _CreateLabelState();
}

class _CreateLabelState extends State<CreateLabel> {
  final _formKey = GlobalKey<FormState>();

  final sizeController = TextEditingController();
  final partyController = TextEditingController();
  final totalController = TextEditingController();

  String? selectedStatus;
  String? selectedType;

  final statusOptions = ["Front", "Back", "Neck"];
  final typeOptions = ["1 Liter", "750ml", "500ml"];

  @override
  Widget build(BuildContext context) {
    return BlocListener<MaterialManagementBloc, MaterialManagementState>(
      listener: (context, state) {
        if (state is CreateLableEntrySuccess) {
          snackbar(
            context,
            message: state.message,
            color: Colors.green,
            title: "Success",
          );

          _formKey.currentState!.reset();
          sizeController.clear();
          partyController.clear();
          totalController.clear();
          setState(() {
            selectedStatus = null;
            selectedType = null;
          });
        }

        if (state is CreateLableEntryFailure) {
          snackbar(context, message: state.error);
        }
      },
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: numField(sizeController, "Size")),
                const SizedBox(width: 20),
                Expanded(child: textField(partyController, "Party Name")),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: numField(totalController, "Total Lable Per Case"),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: dropdownField(
                    "Lable Status",
                    statusOptions,
                    selectedStatus,
                    (val) => setState(() => selectedStatus = val),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: dropdownField(
                    "Lable Type",
                    typeOptions,
                    selectedType,
                    (val) => setState(() => selectedType = val),
                  ),
                ),
                const SizedBox(width: 20),
                BlocBuilder<MaterialManagementBloc, MaterialManagementState>(
                  builder: (context, state) {
                    return FilledButton(
                      onPressed: state is CreateLableEntryLoading
                          ? null
                          : () {
                              if (!_formKey.currentState!.validate()) return;

                              context.read<MaterialManagementBloc>().add(
                                CreateLableEntryEvent(
                                  size: int.parse(sizeController.text.trim()),
                                  partyName: partyController.text.trim(),
                                  totalLablePerCase: int.parse(
                                    totalController.text.trim(),
                                  ),
                                  lableStatus: selectedStatus!,
                                  lableType: selectedType!,
                                ),
                              );
                            },
                      child: state is CreateLableEntryLoading
                          ? const SizedBox(
                              height: 16,
                              width: 16,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Text("Create Label"),
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
/// UPDATE LABEL
////////////////////////////////////////////////////////////

class UpdateLabel extends StatefulWidget {
  const UpdateLabel({super.key});

  @override
  State<UpdateLabel> createState() => _UpdateLabelState();
}

class _UpdateLabelState extends State<UpdateLabel> {
  final _formKey = GlobalKey<FormState>();

  final idController = TextEditingController();
  final sizeController = TextEditingController();
  final partyController = TextEditingController();
  final totalController = TextEditingController();

  String? selectedStatus;
  String? selectedType;

  final statusOptions = ["Front", "Back", "Neck"];
  final typeOptions = ["1 Liter", "750ml", "500ml"];

  @override
  Widget build(BuildContext context) {
    return BlocListener<MaterialManagementBloc, MaterialManagementState>(
      listener: (context, state) {
        if (state is UpdateLableEntrySuccess) {
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
          totalController.clear();
          setState(() {
            selectedStatus = null;
            selectedType = null;
          });
        }

        if (state is UpdateLableEntryFailure) {
          snackbar(context, message: state.error);
        }
      },
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: numField(idController, "Lable ID")),
                const SizedBox(width: 20),
                Expanded(child: numField(sizeController, "Size")),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(child: textField(partyController, "Party Name")),
                const SizedBox(width: 20),
                Expanded(
                  child: numField(totalController, "Total Lable Per Case"),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: dropdownField(
                    "Lable Status",
                    statusOptions,
                    selectedStatus,
                    (val) => setState(() => selectedStatus = val),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: dropdownField(
                    "Lable Type",
                    typeOptions,
                    selectedType,
                    (val) => setState(() => selectedType = val),
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
                        onPressed: state is UpdateLableEntryLoading
                            ? null
                            : () {
                                if (!_formKey.currentState!.validate()) return;

                                context.read<MaterialManagementBloc>().add(
                                  UpdateLableEntryEvent(
                                    updateId: int.parse(
                                      idController.text.trim(),
                                    ),
                                    size: int.parse(sizeController.text.trim()),
                                    partyName: partyController.text.trim(),
                                    totalLablePerCase: int.parse(
                                      totalController.text.trim(),
                                    ),
                                    lableStatus: selectedStatus!,
                                    lableType: selectedType!,
                                  ),
                                );
                              },
                        child: state is UpdateLableEntryLoading
                            ? const SizedBox(
                                height: 16,
                                width: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Text("Update Label"),
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
/// DELETE LABEL
////////////////////////////////////////////////////////////

class DeleteLabel extends StatefulWidget {
  const DeleteLabel({super.key});

  @override
  State<DeleteLabel> createState() => _DeleteLabelState();
}

class _DeleteLabelState extends State<DeleteLabel> {
  final _formKey = GlobalKey<FormState>();
  final idController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<MaterialManagementBloc, MaterialManagementState>(
      listener: (context, state) {
        if (state is DeleteLableEntrySuccessState) {
          snackbar(
            context,
            message: state.message,
            color: Colors.green,
            title: "Success",
          );
          idController.clear();
        }

        if (state is DeleteLableFailureState) {
          snackbar(context, message: state.error);
        }
      },
      child: Form(
        key: _formKey,
        child: Row(
          children: [
            Expanded(child: numField(idController, "Lable ID")),
            const SizedBox(width: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade100,
              ),
              onPressed: () {
                if (!_formKey.currentState!.validate()) return;

                context.read<MaterialManagementBloc>().add(
                  DeleteLableEntryEvent(
                    deleteId: int.parse(idController.text.trim()),
                  ),
                );
              },
              child: const Text(
                "Delete Label",
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
