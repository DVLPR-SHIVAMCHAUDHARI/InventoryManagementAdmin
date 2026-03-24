import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventory_mobile_app/core/routes/routes.dart';
import 'package:inventory_mobile_app/core/services/tokenservice.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1), () {
      TokenServices().accessToken != null
          ? router.goNamed(Routes.homeScreen.name)
          : router.goNamed(Routes.login.name);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: Center(
            child: Text(
              'Inventory Managemnt',
              style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
            ),
          ),
        );
      },
    );
  }
}
