import 'package:flutter/material.dart';

import 'package:inventory_management_admin_pannel/core/Utils/globals.dart';
import 'package:inventory_management_admin_pannel/core/services/tokenservice.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy(); // since you're using flutter_web_plugins

  await TokenServices().load(); // if you have async initialization
  runApp(const InventoryManagementAdmin());
}

class InventoryManagementAdmin extends StatelessWidget {
  const InventoryManagementAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      title: 'Inventory Management System',

      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        scaffoldBackgroundColor: const Color(0xFFF4F6FA),

        // AppBar Styling
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 1,
          shadowColor: Colors.black12,
          iconTheme: IconThemeData(color: Colors.black87),
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),

        // Input Fields
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFFF1F3F6),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),

        // Card Styling
        cardTheme: CardThemeData(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          color: Colors.white,
          shadowColor: Colors.black12,
        ),

        // DataTable Styling
        dataTableTheme: DataTableThemeData(
          headingRowColor: WidgetStateProperty.all(Colors.blue.shade50),
          dataRowColor: WidgetStateProperty.all(Colors.white),
          headingTextStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
          dataTextStyle: const TextStyle(fontSize: 13),
        ),
      ),

      // If you want dark mode:
      // darkTheme: ThemeData.dark(),
    );
  }
}
