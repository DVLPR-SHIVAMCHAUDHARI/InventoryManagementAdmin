import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_management_admin_pannel/core/Utils/snack_bar.dart';
import 'package:inventory_management_admin_pannel/features/materialManagement/bloc/material_management_bloc.dart';
import 'package:inventory_management_admin_pannel/features/materialManagement/bloc/material_management_event.dart';
import 'package:inventory_management_admin_pannel/features/materialManagement/bloc/material_management_state.dart';
import 'package:inventory_management_admin_pannel/features/materialManagement/widgets/helper_class.dart';

class MonoCartonManagementWidget extends StatelessWidget {
  const MonoCartonManagementWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _card(title: "Create Mono Carton", child: const CreateMonoCarton()),
        const SizedBox(height: 24),
        _card(title: "Update Mono Carton", child: const UpdateMonoCarton()),
        const SizedBox(height: 24),
        _card(title: "Delete Mono Carton", child: const DeleteMonoCarton()),
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
/// CREATE MONO CARTON
////////////////////////////////////////////////////////////

class CreateMonoCarton extends StatefulWidget {
  const CreateMonoCarton({super.key});

  @override
  State<CreateMonoCarton> createState() => _CreateMonoCartonState();
}

class _CreateMonoCartonState extends State<CreateMonoCarton> {
  final _formKey = GlobalKey<FormState>();

  final sizeController = TextEditingController();
  final partyController = TextEditingController();
  final totalController = TextEditingController();

  String? status;
  String? type;

  final statusOptions = ["Mid", "Small", "Large"];
  final typeOptions = ["750 Ml", "50ml", "180ml"];

  @override
  Widget build(BuildContext context) {
    return BlocListener<MaterialManagementBloc, MaterialManagementState>(
      listener: (context, state) {
        if (state is CreateMonoCartonEntrySuccess) {
          snackbar(
            context,
            message: state.message,
            color: Colors.green,
            title: "Success",
          );
          _formKey.currentState!.reset();
          setState(() {
            status = null;
            type = null;
          });
        }

        if (state is CreateMonoCartonEntryFailure) {
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
                    validator: requiredNumberValidator,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: textField(
                    partyController,
                    "Party Name",
                    validator: requiredValidator,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: numField(
                    totalController,
                    "Total Mono Carton Per Case",
                    validator: requiredNumberValidator,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: dropdownField(
                    "Mono Carton Status",
                    statusOptions,
                    status,
                    (v) => setState(() => status = v),
                    validator: (v) => v == null ? "Select Status" : null,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: dropdownField(
                    "Mono Carton Type",
                    typeOptions,
                    type,
                    (v) => setState(() => type = v),
                    validator: (v) => v == null ? "Select Type" : null,
                  ),
                ),
                const SizedBox(width: 20),
                BlocBuilder<MaterialManagementBloc, MaterialManagementState>(
                  builder: (context, state) {
                    return FilledButton(
                      onPressed: state is CreateMonoCartonEntryLoading
                          ? null
                          : () {
                              if (!_formKey.currentState!.validate()) return;

                              context.read<MaterialManagementBloc>().add(
                                CreateMonoCartonEntryEvent(
                                  size: int.parse(sizeController.text.trim()),
                                  partyName: partyController.text.trim(),
                                  totalMonoCartonPerCase: int.parse(
                                    totalController.text.trim(),
                                  ),
                                  monoCartonStatus: status!,
                                  monoCartonType: type!,
                                ),
                              );
                            },
                      child: state is CreateMonoCartonEntryLoading
                          ? const SizedBox(
                              height: 16,
                              width: 16,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Text("Create Mono Carton"),
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
/// UPDATE MONO CARTON
////////////////////////////////////////////////////////////

class UpdateMonoCarton extends StatefulWidget {
  const UpdateMonoCarton({super.key});

  @override
  State<UpdateMonoCarton> createState() => _UpdateMonoCartonState();
}

class _UpdateMonoCartonState extends State<UpdateMonoCarton> {
  final _formKey = GlobalKey<FormState>();

  final idController = TextEditingController();
  final sizeController = TextEditingController();
  final partyController = TextEditingController();
  final totalController = TextEditingController();

  String? status;
  String? type;

  final statusOptions = ["Mid", "Small", "Large"];
  final typeOptions = ["750 Ml", "50ml", "180ml"];

  @override
  Widget build(BuildContext context) {
    return BlocListener<MaterialManagementBloc, MaterialManagementState>(
      listener: (context, state) {
        if (state is UpdateMonoCartonEntrySuccess) {
          snackbar(
            context,
            message: state.message,
            color: Colors.green,
            title: "Success",
          );
          _formKey.currentState!.reset();
        }

        if (state is UpdateMonoCartonEntryFailure) {
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
                    "Mono Carton ID",
                    validator: requiredNumberValidator,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: numField(
                    sizeController,
                    "Size",
                    validator: requiredNumberValidator,
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
                    validator: requiredValidator,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: numField(
                    totalController,
                    "Total Mono Carton Per Case",
                    validator: requiredNumberValidator,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: dropdownField(
                    "Mono Carton Status",
                    statusOptions,
                    status,
                    (v) => setState(() => status = v),
                    validator: (v) => v == null ? "Select Status" : null,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: dropdownField(
                    "Mono Carton Type",
                    typeOptions,
                    type,
                    (v) => setState(() => type = v),
                    validator: (v) => v == null ? "Select Type" : null,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerRight,
              child:
                  BlocBuilder<MaterialManagementBloc, MaterialManagementState>(
                    builder: (context, state) {
                      return FilledButton(
                        onPressed: state is UpdateMonoCartonEntryLoading
                            ? null
                            : () {
                                if (!_formKey.currentState!.validate()) return;

                                context.read<MaterialManagementBloc>().add(
                                  UpdateMonoCartonEntryEvent(
                                    updateId: int.parse(
                                      idController.text.trim(),
                                    ),
                                    size: int.parse(sizeController.text.trim()),
                                    partyName: partyController.text.trim(),
                                    totalMonoCartonPerCase: int.parse(
                                      totalController.text.trim(),
                                    ),
                                    monoCartonStatus: status!,
                                    monoCartonType: type!,
                                  ),
                                );
                              },
                        child: state is UpdateMonoCartonEntryLoading
                            ? const SizedBox(
                                height: 18,
                                width: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Text("Update Mono Carton"),
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
/// DELETE MONO CARTON
////////////////////////////////////////////////////////////

class DeleteMonoCarton extends StatefulWidget {
  const DeleteMonoCarton({super.key});

  @override
  State<DeleteMonoCarton> createState() => _DeleteMonoCartonState();
}

class _DeleteMonoCartonState extends State<DeleteMonoCarton> {
  final _formKey = GlobalKey<FormState>();
  final idController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<MaterialManagementBloc, MaterialManagementState>(
      listener: (context, state) {
        if (state is DeleteMonoCartonEntrySuccessState) {
          snackbar(
            context,
            message: state.message,
            color: Colors.green,
            title: "Success",
          );
        }

        if (state is DeleteMonoCartonFailureState) {
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
                "Mono Carton ID",
                validator: requiredNumberValidator,
              ),
            ),
            const SizedBox(width: 20),
            ElevatedButton(
              onPressed: () {
                if (!_formKey.currentState!.validate()) return;

                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text("Confirm Delete"),
                    content: const Text(
                      "Are you sure you want to delete this mono carton?",
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Cancel"),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          context.read<MaterialManagementBloc>().add(
                            DeleteMonoCartonEntryEvent(
                              deleteId: int.parse(idController.text.trim()),
                            ),
                          );
                        },
                        child: const Text("Delete"),
                      ),
                    ],
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade100,
              ),
              child: const Text(
                "Delete Mono Carton",
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
