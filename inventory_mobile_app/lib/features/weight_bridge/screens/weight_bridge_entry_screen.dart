import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'package:inventory_mobile_app/core/consts/appcolors.dart';
import 'package:inventory_mobile_app/core/consts/dimens.dart';
import 'package:inventory_mobile_app/widgets/appdropdown.dart';
import 'package:inventory_mobile_app/widgets/apptextfield.dart';

class WeighBridgeEntryPage extends StatelessWidget {
  WeighBridgeEntryPage({super.key});
  int? selectedGateId = 0;

  final _formKey = GlobalKey<FormState>();

  final gateIdCtrl = TextEditingController(text: 'NA');
  final dateCtrl = TextEditingController();
  final gateTimeCtrl = TextEditingController();
  final invoiceCtrl = TextEditingController();
  final partyCtrl = TextEditingController();
  final lorryCtrl = TextEditingController();
  final driverCtrl = TextEditingController();
  final mobileCtrl = TextEditingController();

  final wbDateCtrl = TextEditingController();
  final wbInTimeCtrl = TextEditingController();

  final materialCtrl = TextEditingController();
  final rstCtrl = TextEditingController();
  final grossWeightCtrl = TextEditingController();
  final grossTimeCtrl = TextEditingController();

  final operatorCtrl = TextEditingController(text: 'Weigh Staff');

  bool _isWide(BuildContext context) {
    return MediaQuery.of(context).size.shortestSide >= 600 ||
        MediaQuery.of(context).orientation == Orientation.landscape;
  }

  @override
  Widget build(BuildContext context) {
    final isWide = _isWide(context);

    return Scaffold(
      backgroundColor: AppColors.background,
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
        _row(_wbDateField(context), _wbInTimeField(context)),
        _gap(),
        _row(_materialField(), _rstField()),
        _gap(),
        _row(_grossWeightField(), _grossTimeField(context)),
        _gap(),
        _operatorField(),
        _gap(24),
        _submitButton(context),
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
        _wbDateField(context),
        _gap(),
        _wbInTimeField(context),
        _gap(),
        _materialField(),
        _gap(),
        _rstField(),
        _gap(),
        _grossWeightField(),
        _gap(),
        _grossTimeField(context),
        _gap(),
        _operatorField(),
        _gap(24),
        _submitButton(context),
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

  Widget _gateIdField() => AppDropdown(
    title: 'Gate Id',
    hint: 'Select Gate',
    items: [1, 2, 3, 4],
    value: selectedGateId == 0 ? null : selectedGateId,
    isRequired: true,
    onChanged: (val) {
      selectedGateId = val;
    },
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
    isRequired: true,
    suffixIcon: const Icon(Icons.access_time, size: 18),
    onTap: () async {
      final t = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (t != null) gateTimeCtrl.text = t.format(context);
    },
  );

  Widget _invoiceField() => AppTextField(
    title: 'Invoice No',
    hint: '',
    controller: invoiceCtrl,
    isRequired: true,
  );

  Widget _partyField() => AppTextField(
    title: 'Party Name',
    hint: '',
    controller: partyCtrl,
    isRequired: true,
  );

  Widget _lorryField() => AppTextField(
    title: 'Lorry No',
    hint: '',
    controller: lorryCtrl,
    isRequired: true,
  );

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

  Widget _wbDateField(BuildContext context) => AppTextField(
    title: 'Weigh bridge In Date',
    hint: 'dd/mm/yyyy',
    controller: wbDateCtrl,
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
        wbDateCtrl.text = DateFormat('dd/MM/yyyy').format(d);
      }
    },
  );

  Widget _wbInTimeField(BuildContext context) => AppTextField(
    title: 'Weigh bridge Intime',
    hint: '--:--',
    controller: wbInTimeCtrl,
    readOnly: true,
    suffixIcon: const Icon(Icons.access_time, size: 18),
    onTap: () async {
      final t = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (t != null) wbInTimeCtrl.text = t.format(context);
    },
  );

  Widget _materialField() => AppTextField(
    title: 'Material Name',
    hint: '',
    controller: materialCtrl,
    isRequired: true,
  );

  Widget _rstField() =>
      AppTextField(title: 'RST No', hint: '', controller: rstCtrl);

  Widget _grossWeightField() => AppTextField(
    title: 'Gross Weight (Kg)',
    hint: '',
    controller: grossWeightCtrl,
    keyboardType: TextInputType.number,
    inputFormatter: [FilteringTextInputFormatter.digitsOnly],
    isRequired: true,
  );

  Widget _grossTimeField(BuildContext context) => AppTextField(
    title: 'Gross Weight Time',
    hint: '--:--',
    controller: grossTimeCtrl,
    readOnly: true,
    suffixIcon: const Icon(Icons.access_time, size: 18),
    onTap: () async {
      final t = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (t != null) grossTimeCtrl.text = t.format(context);
    },
  );

  Widget _operatorField() => AppTextField(
    title: 'Operator',
    hint: '',
    controller: operatorCtrl,
    readOnly: true,
  );

  // ---------------- SUBMIT ----------------

  Widget _submitButton(BuildContext context) {
    return SizedBox(
      height: Dimens.buttonHeight,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Weigh Bridge Entry Saved')),
            );
          }
        },
        child: const Text(
          'SUBMIT',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
