import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventory_mobile_app/core/consts/themedata.dart';
import 'package:inventory_mobile_app/core/routes/routes.dart';

void main() {
  runApp(const InventoryManagementMobile());
}

class InventoryManagementMobile extends StatelessWidget {
  const InventoryManagementMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery.of(context).size.shortestSide >= 600;

    return ScreenUtilInit(
      designSize: Size(360, 800),

      child: MaterialApp.router(
        theme: appTheme(isTablet),
        routerConfig: router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
