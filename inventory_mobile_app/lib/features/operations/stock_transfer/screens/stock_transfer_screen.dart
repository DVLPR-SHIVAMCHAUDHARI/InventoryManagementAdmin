import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventory_mobile_app/core/consts/appcolors.dart';
import 'package:inventory_mobile_app/core/consts/dimens.dart';
import 'package:inventory_mobile_app/core/consts/typography.dart';
import 'package:inventory_mobile_app/widgets/apptextfield.dart';

class StockTransferPage extends StatelessWidget {
  StockTransferPage({super.key});

  final _formKey = GlobalKey<FormState>();

  final itemCtrl = TextEditingController();
  final fromLocationCtrl = TextEditingController();
  final toLocationCtrl = TextEditingController();
  final qtyCtrl = TextEditingController();
  final remarksCtrl = TextEditingController();

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
        leading: BackButton(color: Colors.white),

        title: const Text(
          'Stock Transfer',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primary,
      ),
      body: SafeArea(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: Padding(
            padding: EdgeInsets.all(isWide ? 16.w : 12.w),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _itemDropdown(),
                    Dimens.md.verticalSpace,

                    isWide
                        ? Row(
                            children: [
                              Expanded(child: _fromLocationField()),
                              Dimens.md.horizontalSpace,
                              Expanded(child: _toLocationField()),
                            ],
                          )
                        : Column(
                            children: [
                              _fromLocationField(),
                              Dimens.md.verticalSpace,
                              _toLocationField(),
                            ],
                          ),

                    Dimens.md.verticalSpace,

                    _qtyField(),
                    Dimens.md.verticalSpace,

                    _remarksField(),
                    Dimens.lg.verticalSpace,

                    _submitButton(context),
                    MediaQuery.of(context).viewInsets.bottom > 0
                        ? SizedBox(height: 80.h)
                        : const SizedBox.shrink(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ---------------- FIELDS ----------------

  Widget _itemDropdown() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Item',
        style: TextStyle(
          fontSize: Dimens.label.sp,
          fontFamily: Typo.semiBold,
          color: AppColors.textPrimary,
        ),
      ),
      Dimens.sm.verticalSpace,
      DropdownButtonFormField<String>(
        items: const [
          DropdownMenuItem(value: 'Sugar', child: Text('Sugar')),
          DropdownMenuItem(value: 'Bottle', child: Text('Bottle')),
          DropdownMenuItem(value: 'Packaging', child: Text('Packaging')),
        ],
        onChanged: (_) {},
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please select item';
          }
          return null;
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.primaryLight,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 12.w,
            vertical: 10.h,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimens.fieldRadius.r),
          ),
        ),
      ),
    ],
  );

  Widget _fromLocationField() => AppTextField(
    title: 'From Location',
    hint: 'Warehouse / Rack',
    controller: fromLocationCtrl,
    isRequired: true,
  );

  Widget _toLocationField() => AppTextField(
    title: 'To Location',
    hint: 'Warehouse / Rack',
    controller: toLocationCtrl,
    isRequired: true,
  );

  Widget _qtyField() => AppTextField(
    title: 'Quantity',
    hint: '0',
    controller: qtyCtrl,
    isRequired: true,
    keyboardType: TextInputType.number,
    inputFormatter: [FilteringTextInputFormatter.digitsOnly],
  );

  Widget _remarksField() => AppTextField(
    title: 'Remarks',
    hint: 'Optional',
    controller: remarksCtrl,
    lines: 2,
  );

  // ---------------- SUBMIT ----------------

  Widget _submitButton(BuildContext context) {
    return SizedBox(
      height: Dimens.buttonHeight.h,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimens.fieldRadius.r),
          ),
        ),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Stock Transferred')));
          }
        },
        child: Text(
          'SUBMIT',
          style: TextStyle(
            fontSize: Dimens.button.sp,
            fontFamily: Typo.semiBold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
