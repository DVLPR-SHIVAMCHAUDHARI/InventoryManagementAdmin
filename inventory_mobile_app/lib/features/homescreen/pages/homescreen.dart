import 'package:flutter/material.dart';
import 'package:inventory_mobile_app/core/consts/appcolors.dart';
import 'package:inventory_mobile_app/core/routes/routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  bool _isTablet(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return size.shortestSide >= 600 ||
        MediaQuery.of(context).orientation == Orientation.landscape;
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = _isTablet(context);

    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        backgroundColor: AppColors.primary,
        centerTitle: true,
        toolbarHeight: 48,
        title: const Text(
          'Inventory Home',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(12),
        child: GridView.count(
          crossAxisCount: isTablet ? 3 : 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: isTablet ? 1.3 : 1.1,
          children: [
            _homeTile(
              context,
              icon: Icons.login,
              title: 'Gate Operations',
              subtitle: 'Gate IN / OUT',
              onTap: () => router.pushNamed(Routes.gateEntryExit.name),
            ),
            _homeTile(
              context,
              icon: Icons.scale,
              title: 'Weigh Bridge',
              subtitle: 'IN / OUT',
              onTap: () => router.pushNamed(Routes.weightBridge.name),
            ),
            _homeTile(
              context,
              icon: Icons.local_shipping,
              title: 'Unloading',
              subtitle: 'Material Unloading',
              onTap: () => router.pushNamed(Routes.unloadingPage.name),
            ),
            _homeTile(
              context,
              icon: Icons.groups,
              title: 'Staff Operations',
              subtitle: 'Issue / Transfer',
              onTap: () {
                router.pushNamed(Routes.staffHome.name);
              },
            ),
            // _homeTile(
            //   context,
            //   icon: Icons.bar_chart,
            //   title: 'Reports',
            //   subtitle: 'Daily / Monthly',
            //   onTap: () {
            //     // TODO: Reports screen
            //   },
            // ),
          ],
        ),
      ),
    );
  }

  // ---------------- TILE ----------------

  Widget _homeTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 26,
                backgroundColor: AppColors.primaryLight,
                child: Icon(icon, size: 26, color: AppColors.primary),
              ),
              const SizedBox(height: 10),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
