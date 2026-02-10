import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventory_mobile_app/core/consts/appcolors.dart';
import 'package:inventory_mobile_app/core/consts/dimens.dart';
import 'package:inventory_mobile_app/core/consts/typography.dart';
import 'package:inventory_mobile_app/widgets/apptextfield.dart';

class MaterialIssuePage extends StatelessWidget {
  MaterialIssuePage({super.key});

  final _formKey = GlobalKey<FormState>();

  final itemCtrl = TextEditingController();
  final qtyCtrl = TextEditingController();
  final issueToCtrl = TextEditingController();
  final reasonCtrl = TextEditingController();

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
          'Material Issue',
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
                              Expanded(child: _qtyField()),
                              Dimens.md.horizontalSpace,
                              Expanded(child: _issueToField()),
                            ],
                          )
                        : Column(
                            children: [
                              _qtyField(),
                              Dimens.md.verticalSpace,
                              _issueToField(),
                            ],
                          ),

                    Dimens.md.verticalSpace,

                    _reasonField(),
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

  Widget _qtyField() => AppTextField(
    title: 'Quantity',
    hint: '0',
    controller: qtyCtrl,
    isRequired: true,
    keyboardType: TextInputType.number,
    inputFormatter: [FilteringTextInputFormatter.digitsOnly],
  );

  Widget _issueToField() => AppTextField(
    title: 'Issued To',
    hint: 'Production / Department',
    controller: issueToCtrl,
    isRequired: true,
  );

  Widget _reasonField() => AppTextField(
    title: 'Reason',
    hint: 'Optional',
    controller: reasonCtrl,
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
            ).showSnackBar(const SnackBar(content: Text('Material Issued')));
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
