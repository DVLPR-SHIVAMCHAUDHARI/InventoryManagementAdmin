import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import 'package:inventory_mobile_app/core/consts/appcolors.dart';
import 'package:inventory_mobile_app/core/consts/dimens.dart';
import 'package:inventory_mobile_app/core/consts/typography.dart';
import 'package:inventory_mobile_app/widgets/appdropdown.dart';
import 'package:inventory_mobile_app/widgets/apptextfield.dart';

class WeighBridgeExitPage extends StatefulWidget {
  const WeighBridgeExitPage({super.key});

  @override
  State<WeighBridgeExitPage> createState() => _WeighBridgePageState();
}

class _WeighBridgePageState extends State<WeighBridgeExitPage> {
  int? selectedGateId;

  final _formKey = GlobalKey<FormState>();

  // -------- IN DATA (READ ONLY) --------
  final dateCtrl = TextEditingController();
  final gateTimeCtrl = TextEditingController();
  final invoiceCtrl = TextEditingController();
  final partyCtrl = TextEditingController();
  final lorryCtrl = TextEditingController();
  final driverCtrl = TextEditingController();
  final mobileCtrl = TextEditingController();

  final wbInDateCtrl = TextEditingController();
  final wbInTimeCtrl = TextEditingController();
  final materialCtrl = TextEditingController();
  final rstCtrl = TextEditingController();
  final grossWeightCtrl = TextEditingController();
  final grossTimeCtrl = TextEditingController();

  // -------- OUT DATA --------
  final wbOutDateCtrl = TextEditingController();
  final tareWeightCtrl = TextEditingController();
  final tareTimeCtrl = TextEditingController();
  final netWeightCtrl = TextEditingController();

  final operatorCtrl = TextEditingController(text: 'Weigh Staff');

  bool _isWide(BuildContext context) {
    return MediaQuery.of(context).size.shortestSide >= 600 ||
        MediaQuery.of(context).orientation == Orientation.landscape;
  }

  @override
  Widget build(BuildContext context) {
    final isWide = _isWide(context);

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.white),
        backgroundColor: AppColors.primary,
        title: Text(
          "Weight Bridge ",
          style: TextStyle(
            fontSize: Dimens.title,
            color: Colors.white,
            fontFamily: Typo.bold,
          ),
          textAlign: TextAlign.start,
        ),
      ),
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
        _row(_gateIdField(), _dateField()),
        _gap(),
        _row(_gateTimeField(), _invoiceField()),
        _gap(),
        _row(_partyField(), _lorryField()),
        _gap(),
        _row(_driverField(), _mobileField()),
        _gap(),
        _row(_wbInDateField(), _wbInTimeField()),
        _gap(),
        _row(_materialField(), _rstField()),
        _gap(),
        _row(_grossWeightField(), _grossTimeField()),
        _gap(),
        _row(_wbOutDateField(context), _tareWeightField()),
        _gap(),
        _row(_tareTimeField(context), _netWeightField()),
        _gap(),
        _operatorField(),
        _gap(24),
        _actionButtons(context),
        _gap(),
      ],
    );
  }

  Widget _mobileLayout(BuildContext context) {
    return Column(
      children: [
        _gateIdField(),
        _gap(),
        _dateField(),
        _gap(),
        _gateTimeField(),
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
        _wbInDateField(),
        _gap(),
        _wbInTimeField(),
        _gap(),
        _materialField(),
        _gap(),
        _rstField(),
        _gap(),
        _grossWeightField(),
        _gap(),
        _grossTimeField(),
        _gap(),
        _wbOutDateField(context),
        _gap(),
        _tareWeightField(),
        _gap(),
        _tareTimeField(context),
        _gap(),
        _netWeightField(),
        _gap(),
        _operatorField(),
        _gap(24),
        _actionButtons(context),
        _gap(),
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
    onChanged: (val) => setState(() => selectedGateId = val),
  );

  Widget _dateField() => AppTextField(
    title: 'Date',
    hint: '',
    readOnly: true,
    controller: dateCtrl,
  );

  Widget _gateTimeField() => AppTextField(
    title: 'Gate Time',
    hint: '',
    controller: gateTimeCtrl,
    readOnly: true,
  );

  Widget _invoiceField() => AppTextField(
    title: 'Invoice No',
    hint: '',
    controller: invoiceCtrl,
    readOnly: true,
  );

  Widget _partyField() => AppTextField(
    title: 'Party Name',
    hint: '',
    controller: partyCtrl,
    readOnly: true,
  );

  Widget _lorryField() => AppTextField(
    title: 'Lorry No',
    hint: '',
    controller: lorryCtrl,
    readOnly: true,
  );

  Widget _driverField() => AppTextField(
    title: 'Driver Name',
    hint: '',
    controller: driverCtrl,
    readOnly: true,
  );

  Widget _mobileField() => AppTextField(
    title: 'Driver Mobile No',
    hint: '',
    controller: mobileCtrl,
    readOnly: true,
  );

  Widget _wbInDateField() => AppTextField(
    title: 'Weigh bridge In Date',
    hint: '',
    controller: wbInDateCtrl,
    readOnly: true,
  );

  Widget _wbInTimeField() => AppTextField(
    title: 'Weigh bridge Intime',
    hint: '',
    controller: wbInTimeCtrl,
    readOnly: true,
  );

  Widget _materialField() => AppTextField(
    title: 'Material Name',
    hint: '',
    controller: materialCtrl,
    readOnly: true,
  );

  Widget _rstField() => AppTextField(
    title: 'RST No.',
    hint: '',
    controller: rstCtrl,
    readOnly: true,
  );

  Widget _grossWeightField() => AppTextField(
    title: 'Gross Weight (Kg)',
    hint: '',
    controller: grossWeightCtrl,
    readOnly: true,
  );

  Widget _grossTimeField() => AppTextField(
    title: 'Gross Weight Time',
    hint: '',
    controller: grossTimeCtrl,
    readOnly: true,
  );

  // -------- OUT --------

  Widget _wbOutDateField(BuildContext context) => AppTextField(
    title: 'Weigh Bridge Out Date',
    hint: 'dd/mm/yyyy',
    controller: wbOutDateCtrl,
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
        wbOutDateCtrl.text = DateFormat('dd/MM/yyyy').format(d);
      }
    },
  );

  Widget _tareWeightField() => AppTextField(
    title: 'Tare Weight (Kg)',
    hint: '',
    controller: tareWeightCtrl,
    keyboardType: TextInputType.number,
    isRequired: true,
    inputFormatter: [FilteringTextInputFormatter.digitsOnly],
    onChanged: (val) {
      final gross = double.tryParse(grossWeightCtrl.text) ?? 0;
      final tare = double.tryParse(val) ?? 0;
      if (gross > 0 && tare > 0) {
        netWeightCtrl.text = (gross - tare).toStringAsFixed(0);
      }
    },
  );

  Widget _tareTimeField(BuildContext context) => AppTextField(
    title: 'Tare Weight Time',
    hint: '--:--',
    controller: tareTimeCtrl,
    readOnly: true,
    isRequired: true,
    suffixIcon: const Icon(Icons.access_time, size: 18),
    onTap: () async {
      final t = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (t != null) tareTimeCtrl.text = t.format(context);
    },
  );

  Widget _netWeightField() => AppTextField(
    title: 'Net Weight (Kg)',
    hint: '',
    controller: netWeightCtrl,
    readOnly: true,
  );

  Widget _operatorField() => AppTextField(
    title: 'Operator',
    hint: '',
    controller: operatorCtrl,
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
              onPressed: () {
                _formKey.currentState!.reset();
                tareWeightCtrl.clear();
                tareTimeCtrl.clear();
                wbOutDateCtrl.clear();
                netWeightCtrl.clear();
              },
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
                    const SnackBar(content: Text('Weigh Bridge OUT Submitted')),
                  );
                  context.pop();
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
