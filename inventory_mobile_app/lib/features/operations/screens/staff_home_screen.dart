import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventory_mobile_app/core/consts/appcolors.dart';
import 'package:inventory_mobile_app/core/consts/dimens.dart';
import 'package:inventory_mobile_app/core/routes/routes.dart';

class StaffHomePage extends StatelessWidget {
  const StaffHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isWide =
        MediaQuery.of(context).size.shortestSide >= 600 ||
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: BackButton(color: Colors.white),

        title: const Text(
          'Staff Operations',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primary,
      ),
      body: Padding(
        padding: EdgeInsets.all(isWide ? 16.w : 12.w),
        child: GridView.count(
          crossAxisCount: isWide ? 2 : 1,
          crossAxisSpacing: Dimens.md.w,
          mainAxisSpacing: Dimens.md.h,
          childAspectRatio: isWide ? 3.2 : 4.5,
          children: [
            _actionCard(
              context,
              title: 'Material Receipt',
              icon: Icons.input,
              onTap: () {
                router.pushNamed(Routes.materialReceipt.name);
              },
            ),
            _actionCard(
              context,
              title: 'Material Issue',
              icon: Icons.output,
              onTap: () {
                router.pushNamed(Routes.materialIssue.name);
              },
            ),
            _actionCard(
              context,
              title: 'Stock Transfer',
              icon: Icons.swap_horiz,
              onTap: () {
                router.pushNamed(Routes.stockTransfer.name);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _actionCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(Dimens.fieldRadius.r),
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(Dimens.fieldRadius.r),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        padding: EdgeInsets.all(Dimens.md.w),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(icon, color: AppColors.primary),
            ),
            Dimens.md.horizontalSpace,
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: Dimens.title.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
