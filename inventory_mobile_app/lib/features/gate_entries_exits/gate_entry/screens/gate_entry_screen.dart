import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'package:inventory_mobile_app/core/consts/appcolors.dart';
import 'package:inventory_mobile_app/core/consts/dimens.dart';
import 'package:inventory_mobile_app/core/consts/typography.dart';
import 'package:inventory_mobile_app/widgets/apptextfield.dart';

class GateEntryPage extends StatelessWidget {
  GateEntryPage({super.key});

  final _formKey = GlobalKey<FormState>();

  final dateCtrl = TextEditingController();
  final timeCtrl = TextEditingController();
  final invoiceCtrl = TextEditingController();
  final lorryCtrl = TextEditingController();
  final partyCtrl = TextEditingController();
  final driverCtrl = TextEditingController();
  final mobileCtrl = TextEditingController();
  final securityCtrl = TextEditingController(text: 'Gate Staff');

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
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1100),
            child: Padding(
              padding: EdgeInsets.all(isWide ? 16.w : 12.w),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: isWide
                            ? _wideLayout(context)
                            : _mobileLayout(context),
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
    );
  }

  // ---------------- LAYOUTS ----------------

  Widget _wideLayout(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _dateField(context)),
            Dimens.md.horizontalSpace,
            Expanded(child: _timeField(context)),
          ],
        ),
        Dimens.md.verticalSpace,
        Row(
          children: [
            Expanded(child: _invoiceField()),
            Dimens.md.horizontalSpace,
            Expanded(child: _lorryField()),
          ],
        ),
        Dimens.md.verticalSpace,
        Row(
          children: [
            Expanded(child: _partyField()),
            Dimens.md.horizontalSpace,
            Expanded(child: _driverField()),
          ],
        ),
        Dimens.md.verticalSpace,
        Row(
          children: [
            Expanded(child: _mobileField()),
            Dimens.md.horizontalSpace,
            Expanded(child: _securityField()),
          ],
        ),
      ],
    );
  }

  Widget _mobileLayout(BuildContext context) {
    return Column(
      children: [
        _dateField(context),
        Dimens.md.verticalSpace,
        _timeField(context),
        Dimens.md.verticalSpace,
        _invoiceField(),
        Dimens.md.verticalSpace,
        _lorryField(),
        Dimens.md.verticalSpace,
        _partyField(),
        Dimens.md.verticalSpace,
        _driverField(),
        Dimens.md.verticalSpace,
        _mobileField(),
        Dimens.md.verticalSpace,
        _securityField(),
      ],
    );
  }

  // ---------------- FIELDS ----------------

  Widget _dateField(BuildContext context) => AppTextField(
    title: 'Date',
    hint: 'DD/MM/YYYY',
    controller: dateCtrl,
    isRequired: true,
    suffixIcon: const Icon(Icons.calendar_today, size: 18),
    onTap: () async {
      FocusScope.of(context).unfocus();
      final date = await showDatePicker(
        context: context,
        firstDate: DateTime(2020),
        lastDate: DateTime(2100),
        initialDate: DateTime.now(),
      );
      if (date != null) {
        dateCtrl.text = DateFormat('dd/MM/yyyy').format(date);
      }
    },
    readOnly: true,
  );

  Widget _timeField(BuildContext context) => AppTextField(
    title: 'Gate Time',
    hint: 'HH:MM',
    controller: timeCtrl,
    isRequired: true,
    suffixIcon: const Icon(Icons.access_time, size: 18),
    onTap: () async {
      FocusScope.of(context).unfocus();
      final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (time != null) {
        timeCtrl.text = time.format(context);
      }
    },
    readOnly: true,
  );

  Widget _invoiceField() => AppTextField(
    title: 'Invoice Number',
    hint: 'Invoice no',
    controller: invoiceCtrl,
    isRequired: true,
  );

  Widget _lorryField() => AppTextField(
    title: 'Lorry Number',
    hint: 'Vehicle no',
    controller: lorryCtrl,
    isRequired: true,
  );

  Widget _partyField() => AppTextField(
    title: 'Party Name',
    hint: 'Party / Supplier',
    controller: partyCtrl,
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

  Widget _securityField() => AppTextField(
    title: 'Security',
    hint: '',
    controller: securityCtrl,
    readOnly: true,
  );

  // ---------------- BUTTONS ----------------

  Widget _actionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: Dimens.buttonHeight.h,
            child: OutlinedButton(
              onPressed: () {
                _formKey.currentState!.reset();
                dateCtrl.clear();
                timeCtrl.clear();
                invoiceCtrl.clear();
                lorryCtrl.clear();
                partyCtrl.clear();
                driverCtrl.clear();
                mobileCtrl.clear();
              },
              child: Text(
                'RESET',
                style: TextStyle(
                  fontSize: Dimens.button, // 👈 NO .sp
                  fontFamily: Typo.semiBold,
                ),
              ),
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
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Gate Entry Submitted')),
                  );
                }
              },
              child: Text(
                'SUBMIT',
                style: TextStyle(
                  fontSize: Dimens.button, // 👈 NO .sp
                  fontFamily: Typo.semiBold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
