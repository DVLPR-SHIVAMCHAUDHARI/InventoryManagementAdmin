import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_mobile_app/core/consts/snack_bar.dart';
import 'package:inventory_mobile_app/features/master/bloc/master_bloc.dart';
import 'package:inventory_mobile_app/features/master/bloc/master_event.dart';
import 'package:inventory_mobile_app/features/master/bloc/master_state.dart';
import 'package:inventory_mobile_app/features/unloading/bloc/unloading_bloc.dart';
import 'package:inventory_mobile_app/features/unloading/bloc/unloading_event.dart';
import 'package:inventory_mobile_app/features/unloading/bloc/unloading_state.dart';

class CartonEntryForm extends StatefulWidget {
  const CartonEntryForm({super.key});

  @override
  State<CartonEntryForm> createState() => _CartonEntryFormState();
}

class _CartonEntryFormState extends State<CartonEntryForm> {
  final _formKey = GlobalKey<FormState>();

  final gateIdController = TextEditingController();
  final palletCodeController = TextEditingController();
  final palletQtyController = TextEditingController();
  final warehouseIdController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<MasterBloc>().add(GetCartonListEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MasterBloc, MasterState>(
      builder: (context, masterState) {
        if (masterState is GetCartonListLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (masterState is GetCartonListFailure) {
          return const Center(child: Text("Failed to load Cartons"));
        }

        final CartonList = masterState is GetCartonListSuccess
            ? masterState.cartons
            : [];

        return Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Raw Carton Entry",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 20),

                _numberField("Gate ID", gateIdController),
                _textField("Pallet Unique Code", palletCodeController),
                _numberField("Pallet Quantity", palletQtyController),

                /// 🔥 Carton Dropdown
                Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: BlocBuilder<UnloadingBloc, UnloadingState>(
                    builder: (context, unloadState) {
                      return DropdownButtonFormField2<int>(
                        value: unloadState.cartonId,
                        validator: (val) =>
                            val == null ? "Select Carton" : null,
                        decoration: _inputDecoration("Carton"),
                        isExpanded: true,
                        items: CartonList.map((Carton) {
                          return DropdownMenuItem<int>(
                            value: Carton["id"],
                            child: Text(
                              "${Carton["size"]} - ${Carton["party_name"]}",
                              overflow: TextOverflow.ellipsis,
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          context.read<UnloadingBloc>().add(
                            SwitchCartonId(value),
                          );
                        },
                      );
                    },
                  ),
                ),

                _numberField("Rack ID", warehouseIdController),

                const SizedBox(height: 24),

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
                      child: BlocConsumer<UnloadingBloc, UnloadingState>(
                        listener: (context, state) {
                          if (state.isSuccess) {
                            snackbar(
                              context,
                              color: Colors.green,
                              message: "Carton entry successful",
                              title: "Success",
                            );

                            _resetForm();

                            context.read<UnloadingBloc>().add(
                              const SwitchCartonId(null),
                            );
                          }

                          if (state.error != null) {
                            snackbar(context, message: state.error);
                          }
                        },
                        builder: (context, state) {
                          return ElevatedButton(
                            onPressed: state.isSubmitting
                                ? null
                                : () => _submit(state),
                            child: state.isSubmitting
                                ? const SizedBox(
                                    height: 18,
                                    width: 18,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                : const Text("SUBMIT"),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _submit(UnloadingState state) {
    if (!_formKey.currentState!.validate()) return;

    if (state.cartonId == null) {
      snackbar(context, message: "Please select Carton");
      return;
    }

    context.read<UnloadingBloc>().add(
      SubmitCartonEntry(
        gateId: int.parse(gateIdController.text.trim()),
        palletCode: palletCodeController.text.trim(),
        palletQty: int.parse(palletQtyController.text.trim()),
        cartonId: state.cartonId!,
        warehouseId: int.parse(warehouseIdController.text.trim()),
      ),
    );
  }

  void _resetForm() {
    _formKey.currentState?.reset();
    gateIdController.clear();
    palletCodeController.clear();
    palletQtyController.clear();
    warehouseIdController.clear();
  }

  Widget _textField(String Carton, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextFormField(
        controller: controller,
        validator: (value) => value == null || value.trim().isEmpty
            ? "$Carton is required"
            : null,
        decoration: _inputDecoration(Carton),
      ),
    );
  }

  Widget _numberField(String Carton, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return "$Carton is required";
          }
          if (int.tryParse(value) == null) {
            return "Enter valid number";
          }
          return null;
        },
        decoration: _inputDecoration(Carton),
      ),
    );
  }

  InputDecoration _inputDecoration(String Carton) {
    return InputDecoration(
      labelText: Carton,
      filled: true,
      fillColor: const Color(0xFFF3F4F6),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }
}
