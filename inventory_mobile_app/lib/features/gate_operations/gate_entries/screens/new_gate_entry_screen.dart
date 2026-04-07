import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventory_mobile_app/core/consts/appcolors.dart';
import 'package:inventory_mobile_app/core/consts/dimens.dart';
import 'package:inventory_mobile_app/core/consts/snack_bar.dart';
import 'package:inventory_mobile_app/core/consts/typography.dart';
import 'package:inventory_mobile_app/features/gate_operations/gate_entries/bloc/gate_entry_bloc.dart';
import 'package:inventory_mobile_app/features/gate_operations/gate_entries/bloc/gate_entry_event.dart';
import 'package:inventory_mobile_app/features/gate_operations/gate_entries/bloc/gate_entry_state.dart';

import 'package:inventory_mobile_app/features/master/bloc/master_bloc.dart';
import 'package:inventory_mobile_app/features/master/bloc/master_party_bloc.dart';
import 'package:inventory_mobile_app/features/master/bloc/master_state.dart';
import 'package:inventory_mobile_app/features/master/master_model/party_model.dart';
import 'package:inventory_mobile_app/widgets/appdropdown.dart';
import 'package:inventory_mobile_app/widgets/apptextfield.dart';

class NewGateEntryPage extends StatefulWidget {
  const NewGateEntryPage({super.key});

  @override
  State<NewGateEntryPage> createState() => _NewGateEntryPageState();
}

class _NewGateEntryPageState extends State<NewGateEntryPage> {
  final _formKey = GlobalKey<FormState>();

  final weightCtrl = TextEditingController();
  final invoiceCtrl = TextEditingController();
  final lorryCtrl = TextEditingController();
  final driverCtrl = TextEditingController();
  final mobileCtrl = TextEditingController();

  int? selectedPartyId;
  PartyModel? selectedParty;

  int truckType = 1; // 1 = Filled, 2 = Empty
  bool get isFilled => truckType == 1;

  bool _isWide(BuildContext context) {
    return MediaQuery.of(context).size.shortestSide >= 600 ||
        MediaQuery.of(context).orientation == Orientation.landscape;
  }

  Widget _truckTypeSelector() {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() => truckType = 1);
            },
            child: Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: truckType == 1 ? AppColors.primary : Colors.white,
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: AppColors.primary),
              ),
              child: Center(
                child: Text(
                  "Filled Truck",
                  style: TextStyle(
                    color: truckType == 1 ? Colors.white : AppColors.primary,
                    fontFamily: Typo.semiBold,
                  ),
                ),
              ),
            ),
          ),
        ),
        Dimens.md.horizontalSpace,
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                truckType = 2;
                selectedParty = null;
                selectedPartyId = null;
                invoiceCtrl.clear();
              });
            },
            child: Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: truckType == 2 ? AppColors.primary : Colors.white,
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: AppColors.primary),
              ),
              child: Center(
                child: Text(
                  "Empty Truck",
                  style: TextStyle(
                    color: truckType == 2 ? Colors.white : AppColors.primary,
                    fontFamily: Typo.semiBold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final isWide = _isWide(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1100),
            child: Padding(
              padding: EdgeInsets.all(isWide ? 16.w : 12.w),
              child: Form(
                key: _formKey,
                child: BlocListener<GateEntryBloc, GateEntryState>(
                  listener: (context, state) {
                    if (state is GateEntrySuccess) {
                      snackbar(
                        context,
                        color: Colors.green,
                        title: "Success",
                        message: state.message,
                      );

                      _formKey.currentState!.reset();
                      invoiceCtrl.clear();
                      lorryCtrl.clear();
                      driverCtrl.clear();
                      mobileCtrl.clear();
                      weightCtrl.clear();
                      selectedPartyId = null;
                    }

                    if (state is GateEntryFailure) {
                      snackbar(
                        context,
                        color: Colors.red,
                        title: "Error",
                        message: state.message,
                      );
                    }
                  },
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              _truckTypeSelector(),
                              Dimens.md.verticalSpace,
                              isWide
                                  ? _wideLayout(context)
                                  : _mobileLayout(context),
                            ],
                          ),
                        ),
                      ),
                      Dimens.md.verticalSpace,
                      _actionButtons(context),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _wideLayout(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            if (isFilled) Expanded(child: _invoiceField()),
            if (isFilled) Dimens.md.horizontalSpace,
            Expanded(child: _lorryField()),
          ],
        ),
        Dimens.md.verticalSpace,
        Row(
          children: [
            if (isFilled) Expanded(child: partydropdown()),
            if (isFilled) Dimens.md.horizontalSpace,
            Expanded(child: _driverField()),
          ],
        ),
        Dimens.md.verticalSpace,
        Row(
          children: [
            Expanded(child: _weightField()),
            Dimens.md.horizontalSpace,
            Expanded(child: _mobileField()),
          ],
        ),
      ],
    );
  }

  Widget _mobileLayout(BuildContext context) {
    return Column(
      children: [
        if (isFilled) _invoiceField(),
        if (isFilled) Dimens.md.verticalSpace,
        _lorryField(),
        Dimens.md.verticalSpace,
        if (isFilled) partydropdown(),
        if (isFilled) Dimens.md.verticalSpace,
        _driverField(),
        Dimens.md.verticalSpace,
        _mobileField(),
        Dimens.md.verticalSpace,
        _weightField(),
      ],
    );
  }

  BlocBuilder<PartyBloc, PartyState> partydropdown() {
    return BlocBuilder<PartyBloc, PartyState>(
      builder: (context, state) {
        if (state is PartyLoading) {
          return const AppDropdownShimmer(title: "Party");
        }

        if (state is PartyError) {
          return const Text("Could not load Parties");
        }

        if (state is PartyLoaded) {
          return AppDropdown2<PartyModel>(
            title: "Select Party",
            hint: "Party",
            items: state.parties,
            value: selectedParty,
            label: (party) => party.name ?? "",
            onChanged: (party) {
              setState(() {
                selectedParty = party;
                selectedPartyId = party?.id;
              });
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _weightField() => AppTextField(
    title: 'Vehicle Weight',
    hint: 'Enter weight',
    controller: weightCtrl,
    keyboardType: TextInputType.number,
    isRequired: true,
    inputFormatter: [FilteringTextInputFormatter.digitsOnly],
  );

  Widget _invoiceField() => AppTextField(
    title: 'Invoice Number',
    hint: 'Invoice no',
    controller: invoiceCtrl,
    isRequired: true,
  );

  Widget _lorryField() => AppTextField(
    title: 'Vehicle Number',
    hint: 'Vehicle no',
    controller: lorryCtrl,
    isRequired: true,
  );

  Widget _driverField() => AppTextField(
    title: 'Driver Name',
    hint: 'Driver name',
    controller: driverCtrl,
    isRequired: true,
  );

  Widget _mobileField() => AppTextField(
    title: 'Driver Mobile No.',
    hint: '10 digit number',
    controller: mobileCtrl,
    keyboardType: TextInputType.phone,
    isRequired: true,
    inputFormatter: [
      FilteringTextInputFormatter.digitsOnly,
      LengthLimitingTextInputFormatter(10),
    ],
  );

  Widget _actionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: Dimens.buttonHeight.h,
            child: OutlinedButton(
              onPressed: () {
                _formKey.currentState!.reset();
                invoiceCtrl.clear();
                lorryCtrl.clear();
                driverCtrl.clear();
                mobileCtrl.clear();
                weightCtrl.clear();
                setState(() {
                  selectedPartyId = null;
                  selectedParty = null;
                });
              },
              child: Text('RESET'),
            ),
          ),
        ),
        Dimens.md.horizontalSpace,
        Expanded(
          child: SizedBox(
            height: Dimens.buttonHeight.h,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  if (isFilled && selectedPartyId == null) {
                    snackbar(
                      context,
                      color: Colors.red,
                      title: "Error",
                      message: "Please select party",
                    );
                    return;
                  }
                  final now = TimeOfDay.now();
                  final time =
                      "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";
                  context.read<GateEntryBloc>().add(
                    SubmitGateEntryEvent(
                      date: DateTime.now().toString().split(' ')[0],
                      time: time,
                      truckType: truckType,
                      driverName: driverCtrl.text.trim(),
                      vehicleNo: lorryCtrl.text.trim(),
                      vehicleWeight: int.parse(weightCtrl.text.trim()),
                      driverMobileNo: mobileCtrl.text.trim(),
                      partyId: isFilled ? selectedPartyId : null,
                      invoiceNo: isFilled ? invoiceCtrl.text.trim() : null,
                    ),
                  );
                }
              },
              child: BlocBuilder<GateEntryBloc, GateEntryState>(
                builder: (context, state) {
                  if (state is GateEntryLoading) {
                    return const CircularProgressIndicator(color: Colors.white);
                  }
                  return const Text('SUBMIT');
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
