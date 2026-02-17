import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_management_admin_pannel/features/materialManagement/bloc/material_management_bloc.dart';

import 'package:inventory_management_admin_pannel/features/materialManagement/widgets/bottle_management.dart';
import 'package:inventory_management_admin_pannel/features/materialManagement/widgets/cap_management.dart';
import 'package:inventory_management_admin_pannel/features/materialManagement/widgets/carton_management.dart';
import 'package:inventory_management_admin_pannel/features/materialManagement/widgets/label_management.dart';
import 'package:inventory_management_admin_pannel/features/materialManagement/widgets/mono_carton_management.dart';

class MaterialManagementScreen extends StatefulWidget {
  const MaterialManagementScreen({super.key});

  @override
  State<MaterialManagementScreen> createState() =>
      _MaterialManagementScreenState();
}

class _MaterialManagementScreenState extends State<MaterialManagementScreen> {
  String selectedMaterial = "Bottle";

  final List<String> materials = [
    "Bottle",
    "Cap",
    "Label",
    "Carton",
    "Mono Carton",
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double maxWidth = constraints.maxWidth;
          double contentWidth = maxWidth > 1200 ? 1200 : maxWidth * 0.95;

          return SingleChildScrollView(
            child: Container(
              width: maxWidth,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// TITLE
                  Text(
                    "$selectedMaterial Entry Management",
                    style: TextStyle(
                      fontSize: contentWidth * 0.018,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey[900],
                    ),
                  ),

                  const SizedBox(height: 12),
                  const Divider(),
                  const SizedBox(height: 30),

                  /// MATERIAL DROPDOWN
                  Row(
                    children: [
                      Text(
                        "Select Material:",
                        style: TextStyle(
                          fontSize: contentWidth * 0.012,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: DropdownButton<String>(
                          value: selectedMaterial,
                          underline: const SizedBox(),
                          items: materials
                              .map(
                                (e) =>
                                    DropdownMenuItem(value: e, child: Text(e)),
                              )
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedMaterial = value!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  /// DYNAMIC MATERIAL WIDGET (THIS IS THE KEY)
                  BlocProvider(
                    create: (context) => MaterialManagementBloc(),
                    child: _buildMaterialWidget(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMaterialWidget() {
    switch (selectedMaterial) {
      case "Bottle":
        return const BottleManagementWidget();

      case "Cap":
        return const CapManagementWidget();

      case "Label":
        return const LabelManagementWidget();

      case "Carton":
        return const CartonManagementWidget();

      case "Mono Carton":
        return const MonoCartonManagementWidget();

      default:
        return const SizedBox();
    }
  }
}
