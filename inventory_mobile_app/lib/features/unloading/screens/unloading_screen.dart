import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'package:inventory_mobile_app/core/consts/appcolors.dart';
import 'package:inventory_mobile_app/core/consts/dimens.dart';
import 'package:inventory_mobile_app/widgets/appdropdown.dart';
import 'package:inventory_mobile_app/widgets/apptextfield.dart';

class UnloadingPage extends StatelessWidget {
  UnloadingPage({super.key});

  final _formKey = GlobalKey<FormState>();

  // -------- BASIC DETAILS --------
  int? selectedGateId;
  final dateCtrl = TextEditingController();
  final gateTimeCtrl = TextEditingController();
  final invoiceCtrl = TextEditingController();
  final partyCtrl = TextEditingController();
  final lorryCtrl = TextEditingController();
  final driverCtrl = TextEditingController();
  final mobileCtrl = TextEditingController();

  // -------- UNLOADING --------
  final unloadingDateCtrl = TextEditingController();
  final unloadingTimeCtrl = TextEditingController();
  final unloadingDoneCtrl = TextEditingController();
  final unloadingDetailsCtrl = TextEditingController();
  final bardanaReceivedCtrl = TextEditingController();

  final supervisorCtrl = TextEditingController(text: 'Unloading Staff');

  bool _isWide(BuildContext context) {
    return MediaQuery.of(context).size.shortestSide >= 600 ||
        MediaQuery.of(context).orientation == Orientation.landscape;
  }

  @override
  Widget build(BuildContext context) {
    final isWide = _isWide(context);

    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 1,

        centerTitle: true,
        toolbarHeight: 48, // 👈 SMALL HEIGHT
        title: const Text(
          'Unloading',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        leading: BackButton(color: Colors.white),
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: isWide ? _tabletLayout(context) : _mobileLayout(context),
            ),
          ),
        ),
      ),
    );
  }

  // ---------------- LAYOUTS ----------------

  Widget _tabletLayout(BuildContext context) {
    return Column(
      children: [
        _row(_gateIdField(), _dateField(context)),
        _gap(),
        _row(_gateTimeField(context), _invoiceField()),
        _gap(),
        _row(_partyField(), _lorryField()),
        _gap(),
        _row(_driverField(), _mobileField()),
        _gap(),
        _row(_unloadingDateField(context), _unloadingTimeField(context)),
        _gap(),
        _row(_unloadingDoneField(), _unloadingDetailsField()),
        _gap(),
        _row(_unloadingLocationField(), _bardanaReceivedField()),
        _gap(),
        _supervisorField(),
        _gap(24),
        _actionButtons(context),
      ],
    );
  }

  Widget _mobileLayout(BuildContext context) {
    return Column(
      children: [
        _gateIdField(),
        _gap(),
        _dateField(context),
        _gap(),
        _gateTimeField(context),
        _gap(),
        _invoiceField(),
        _gap(),
        _partyField(),
        _gap(),
        _lorryField(),
        _gap(),
        _driverField(),
        _gap(),
        _mobileField(),
        _gap(),
        _unloadingDateField(context),
        _gap(),
        _unloadingTimeField(context),
        _gap(),
        _unloadingDoneField(),
        _gap(),
        _unloadingDetailsField(),
        _gap(),
        _unloadingLocationField(),
        _gap(),
        _bardanaReceivedField(),
        _gap(),
        _supervisorField(),
        _gap(24),
        _actionButtons(context),
      ],
    );
  }

  Widget _row(Widget left, Widget right) {
    return Row(
      children: [
        Expanded(child: left),
        const SizedBox(width: 12),
        Expanded(child: right),
      ],
    );
  }

  Widget _gap([double h = 12]) => SizedBox(height: h);

  // ---------------- FIELDS ----------------

  Widget _gateIdField() => AppDropdown<int>(
    title: 'Gate Id',
    hint: 'Select Gate',
    items: const [1, 2, 3, 4],
    value: selectedGateId,
    isRequired: true,
    onChanged: (val) => selectedGateId = val,
  );

  Widget _dateField(BuildContext context) => AppTextField(
    title: 'Date',
    hint: 'dd/mm/yyyy',
    controller: dateCtrl,
    readOnly: true,
    isRequired: true,
    suffixIcon: const Icon(Icons.calendar_today, size: 18),
    onTap: () async {
      final d = await showDatePicker(
        context: context,
        firstDate: DateTime(2020),
        lastDate: DateTime(2100),
        initialDate: DateTime.now(),
      );
      if (d != null) {
        dateCtrl.text = DateFormat('dd/MM/yyyy').format(d);
      }
    },
  );

  Widget _gateTimeField(BuildContext context) => AppTextField(
    title: 'Gate Time',
    hint: '--:--',
    controller: gateTimeCtrl,
    readOnly: true,
    suffixIcon: const Icon(Icons.access_time, size: 18),
    onTap: () async {
      final t = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (t != null) gateTimeCtrl.text = t.format(context);
    },
  );

  Widget _invoiceField() =>
      AppTextField(title: 'Invoice No', hint: '', controller: invoiceCtrl);

  Widget _partyField() =>
      AppTextField(title: 'Party Name', hint: '', controller: partyCtrl);

  Widget _lorryField() =>
      AppTextField(title: 'Lorry No', hint: '', controller: lorryCtrl);

  Widget _driverField() =>
      AppTextField(title: 'Driver Name', hint: '', controller: driverCtrl);

  Widget _mobileField() => AppTextField(
    title: 'Driver Mobile No',
    hint: '',
    controller: mobileCtrl,
    keyboardType: TextInputType.phone,
    inputFormatter: [
      FilteringTextInputFormatter.digitsOnly,
      LengthLimitingTextInputFormatter(10),
    ],
  );

  Widget _unloadingDateField(BuildContext context) => AppTextField(
    title: 'Unloading Date',
    hint: 'dd/mm/yyyy',
    controller: unloadingDateCtrl,
    readOnly: true,
    suffixIcon: const Icon(Icons.calendar_today, size: 18),
    onTap: () async {
      final d = await showDatePicker(
        context: context,
        firstDate: DateTime(2020),
        lastDate: DateTime(2100),
        initialDate: DateTime.now(),
      );
      if (d != null) {
        unloadingDateCtrl.text = DateFormat('dd/MM/yyyy').format(d);
      }
    },
  );

  Widget _unloadingTimeField(BuildContext context) => AppTextField(
    title: 'Unloading Time',
    hint: '--:--',
    controller: unloadingTimeCtrl,
    readOnly: true,
    suffixIcon: const Icon(Icons.access_time, size: 18),
    onTap: () async {
      final t = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (t != null) unloadingTimeCtrl.text = t.format(context);
    },
  );

  Widget _unloadingDoneField() => AppTextField(
    title: 'Unloading Done or Not',
    hint: 'Yes / No',
    controller: unloadingDoneCtrl,
    isRequired: true,
  );

  Widget _unloadingDetailsField() => AppTextField(
    title: 'Unloading Details',
    hint: '',
    controller: unloadingDetailsCtrl,
  );

  Widget _unloadingLocationField() => AppDropdown<String>(
    title: 'Unloading Location',
    hint: 'Select your option',
    items: const ['Godown A', 'Godown B', 'Open Yard'],
    value: null,
    onChanged: (_) {},
    isRequired: true,
  );

  Widget _bardanaReceivedField() => AppTextField(
    title: 'Bardana Received',
    hint: 'Yes / No',
    controller: bardanaReceivedCtrl,
  );

  Widget _supervisorField() => AppTextField(
    title: 'Supervisor',
    hint: '',
    controller: supervisorCtrl,
    readOnly: true,
  );

  // ---------------- ACTIONS ----------------

  Widget _actionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: Dimens.buttonHeight,
            child: OutlinedButton(
              onPressed: () => _formKey.currentState!.reset(),
              child: const Text('RESET'),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: SizedBox(
            height: Dimens.buttonHeight,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Unloading details saved')),
                  );
                }
              },
              child: const Text(
                'SUBMIT',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
