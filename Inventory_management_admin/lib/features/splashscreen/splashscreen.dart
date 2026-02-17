import 'package:flutter/material.dart';
import 'package:inventory_management_admin_pannel/core/Utils/asset_url.dart';
import 'package:inventory_management_admin_pannel/core/Utils/globals.dart';
import 'package:inventory_management_admin_pannel/core/services/tokenservice.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      TokenServices().accessToken != null
          ? router.goNamed(Routes.dashboard.name)
          : router.goNamed(Routes.signin.name);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA), // soft modern background
      body: Center(
        child: Container(
          width: 550, // good for tablets/web
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 40),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // App Logo
              SizedBox(
                height: 110,
                width: 110,
                child: Image.asset(
                  AssetUrl.icUnimeshTechnology, // replace with your logo asset
                  fit: BoxFit.contain,
                ),
              ),

              SizedBox(height: 25),

              // Title
              Text(
                "Inventory Management System",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),

              SizedBox(height: 10),

              // Tagline
              Text(
                "Smart Inventory • Fast Operations • Real-Time Control",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey[700],
                ),
              ),

              SizedBox(height: 35),

              // Loader
              const CircularProgressIndicator(
                strokeWidth: 3,
                color: Color(0xff1976D2),
              ),

              SizedBox(height: 40),

              // Branding
              Text(
                "Powered by",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w400,
                ),
              ),

              SizedBox(height: 6),

              Text(
                "Unimesh Technologies Pvt. Ltd.",
                style: TextStyle(
                  fontSize: 17,
                  color: Color(0xff1976D2),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
