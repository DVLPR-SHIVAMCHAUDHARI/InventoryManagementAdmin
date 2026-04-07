import 'package:flutter/material.dart';
import 'package:inventory_mobile_app/core/consts/appcolors.dart';
import 'package:inventory_mobile_app/core/routes/routes.dart';

class GateOperationsPage extends StatelessWidget {
  const GateOperationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        backgroundColor: AppColors.primary,
        centerTitle: true,
        toolbarHeight: 48,
        leading: BackButton(color: Colors.white),
        title: const Text(
          'Gate Operations',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            _tile(
              context,
              icon: Icons.login,
              title: 'Gate Entry',
              subtitle: 'Truck Entry',
              color: Colors.green,
              onTap: () {
                router.pushNamed(Routes.gateEntry.name);
              },
            ),
            const SizedBox(height: 12),
            _tile(
              context,
              icon: Icons.logout,
              title: 'Gate Exit',
              subtitle: 'Truck Exit',
              color: Colors.red,
              onTap: () {
                router.pushNamed(Routes.gateExit.name);
              },
            ),
          ],
        ),
      ),
    );
  }

  // ---------------- TILE ----------------

  Widget _tile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            // Icon
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 26),
            ),

            const SizedBox(width: 12),

            // Text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),

            // Arrow
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
