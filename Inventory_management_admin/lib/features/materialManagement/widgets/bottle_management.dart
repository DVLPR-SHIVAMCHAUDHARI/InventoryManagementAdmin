import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:inventory_management_admin_pannel/core/Utils/snack_bar.dart';
import 'package:inventory_management_admin_pannel/features/materialManagement/bloc/material_management_bloc.dart';
import 'package:inventory_management_admin_pannel/features/materialManagement/bloc/material_management_event.dart';
import 'package:inventory_management_admin_pannel/features/materialManagement/bloc/material_management_state.dart';
import 'package:inventory_management_admin_pannel/features/materialManagement/widgets/helper_class.dart';

class BottleManagementWidget extends StatelessWidget {
  const BottleManagementWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// CREATE
        _card(title: "Create Bottle", child: const CreateBottle()),

        const SizedBox(height: 24),

        /// UPDATE
        _card(title: "Update Bottle", child: const UpdateBottle()),

        const SizedBox(height: 24),

        /// DELETE
        _card(title: "Delete Bottle", child: const DeleteBottle()),
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

class CreateBottle extends StatefulWidget {
  const CreateBottle({super.key});

  @override
  State<CreateBottle> createState() => _CreateBottleState();
}

class _CreateBottleState extends State<CreateBottle> {
  final _formKey = GlobalKey<FormState>();

  final sizeController = TextEditingController();
  final partyController = TextEditingController();
  final totalPerCaseController = TextEditingController();

  String? selectedStatus;
  String? selectedType;

  final List<String> statusOptions = ["Empty", "Filled", "Damaged"];
  final List<String> typeOptions = ["American Oak", "French Oak", "Plastic"];

  @override
  Widget build(BuildContext context) {
    return Form(
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
                  totalPerCaseController,
                  "Total Bottle Per Case",
                  validator: requiredNumberValidator,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: dropdownField(
                  "Bottle Status",
                  statusOptions,
                  selectedStatus,
                  (val) => setState(() => selectedStatus = val),
                  validator: (val) =>
                      val == null ? "Select Bottle Status" : null,
                ),
              ),
            ],
          ),

          BlocListener<MaterialManagementBloc, MaterialManagementState>(
            listener: (context, state) {
              if (state is CreateBottleEntrySuccess) {
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
                });
              } else if (state is CreateBottleEntryFailure) {
                snackbar(context, message: state.error);
              }
            },
            child: const SizedBox(height: 20),
          ),

          Row(
            children: [
              Expanded(
                child: dropdownField(
                  "Bottle Type",
                  typeOptions,
                  selectedType,
                  (val) => setState(() => selectedType = val),
                  validator: (val) => val == null ? "Select Bottle Type" : null,
                ),
              ),
              const SizedBox(width: 20),
              FilledButton(
                onPressed: () {
                  if (!_formKey.currentState!.validate()) return;

                  context.read<MaterialManagementBloc>().add(
                    CreateBottleEntryEvent(
                      size: int.parse(sizeController.text),
                      partyName: partyController.text,
                      totalBottlesPerCase: int.parse(
                        totalPerCaseController.text,
                      ),
                      bottleStatus: selectedStatus!,
                      bottleType: selectedType!,
                    ),
                  );
                },
                child:
                    BlocBuilder<
                      MaterialManagementBloc,
                      MaterialManagementState
                    >(
                      builder: (context, state) {
                        if (state is CreateBottleEntryLoading) {
                          return const SizedBox(
                            height: 16,
                            width: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          );
                        }
                        return Text("Create Bottle");
                      },
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class UpdateBottle extends StatefulWidget {
  const UpdateBottle({super.key});

  @override
  State<UpdateBottle> createState() => _UpdateBottleState();
}

class _UpdateBottleState extends State<UpdateBottle> {
  final _formKey = GlobalKey<FormState>();

  final idController = TextEditingController();
  final sizeController = TextEditingController();
  final partyController = TextEditingController();
  final totalPerCaseController = TextEditingController();

  String? _selectedStatus;
  String? _selectedType;

  final List<String> statusOptions = ["Empty", "Filled", "Damaged"];
  final List<String> typeOptions = ["American Oak", "French Oak", "Plastic"];

  @override
  Widget build(BuildContext context) {
    return BlocListener<MaterialManagementBloc, MaterialManagementState>(
      listener: (context, state) {
        if (state is UpdateBottleEntrySuccess) {
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
            _selectedStatus = null;
            _selectedType = null;
          });
        }

        if (state is UpdateBottleEntryFailure) {
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
                    "Bottle ID",
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
                    totalPerCaseController,
                    "Total Bottle Per Case",
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
                    "Bottle Status",
                    statusOptions,
                    _selectedStatus,
                    (val) => setState(() => _selectedStatus = val),
                    validator: (val) =>
                        val == null ? "Select Bottle Status" : null,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: dropdownField(
                    "Bottle Type",
                    typeOptions,
                    _selectedType,
                    (val) => setState(() => _selectedType = val),
                    validator: (val) =>
                        val == null ? "Select Bottle Type" : null,
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
                        onPressed: state is UpdateBottleEntryLoading
                            ? null
                            : () {
                                if (!_formKey.currentState!.validate()) return;

                                context.read<MaterialManagementBloc>().add(
                                  UpdateBottleEntryEvent(
                                    updateId: int.parse(
                                      idController.text.trim(),
                                    ),
                                    size: int.parse(sizeController.text.trim()),
                                    partyName: partyController.text.trim(),
                                    totalBottlePerCase: int.parse(
                                      totalPerCaseController.text.trim(),
                                    ),
                                    bottleStatus: _selectedStatus!,
                                    bottleType: _selectedType!,
                                  ),
                                );
                              },
                        child: state is UpdateBottleEntryLoading
                            ? const SizedBox(
                                height: 18,
                                width: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Text("Update Bottle"),
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

class DeleteBottle extends StatefulWidget {
  const DeleteBottle({super.key});

  @override
  State<DeleteBottle> createState() => _DeleteBottleState();
}

class _DeleteBottleState extends State<DeleteBottle> {
  final _formKey = GlobalKey<FormState>();
  final idController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<MaterialManagementBloc, MaterialManagementState>(
      listener: (context, state) {
        if (state is DeleteBottleEntrySuccessState) {
          snackbar(
            context,
            message: state.message,
            color: Colors.green,
            title: "Success",
          );
          context.pop();

          idController.clear();
          _formKey.currentState?.reset();
        }

        if (state is DeleteBottleFailureState) {
          snackbar(context, message: state.error);
          context.pop();
        }
      },
      child: Form(
        key: _formKey,
        child: Row(
          children: [
            Expanded(
              child: numField(
                idController,
                "Bottle ID",
                validator: requiredNumberValidator,
              ),
            ),
            const SizedBox(width: 20),

            /// Button with loading state
            BlocBuilder<MaterialManagementBloc, MaterialManagementState>(
              builder: (context, state) {
                final isLoading = state is DeleteBottleLoadingState;

                return ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : () {
                          if (!_formKey.currentState!.validate()) return;
                          _showDeleteConfirmation(context);
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
                          "Delete Bottle",
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

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Confirm Delete"),
        content: const Text("Are you sure you want to delete this bottle?"),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              context.read<MaterialManagementBloc>().add(
                DeleteBottleEntryEvent(
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

Widget textField(
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
