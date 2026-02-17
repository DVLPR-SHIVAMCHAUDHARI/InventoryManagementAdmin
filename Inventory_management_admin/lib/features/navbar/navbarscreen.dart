import 'package:inventory_management_admin_pannel/core/widgets/reusable_management_screen.dart';
import 'package:inventory_management_admin_pannel/features/Department%20Management/screens/department_management_screen.dart';
import 'package:inventory_management_admin_pannel/features/materialManagement/screens/material_management_screen.dart';
import 'package:inventory_management_admin_pannel/features/party_management/screens/party_management_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_management_admin_pannel/core/Utils/asset_url.dart';
import 'package:inventory_management_admin_pannel/core/Utils/globals.dart';
import 'package:inventory_management_admin_pannel/core/services/tokenservice.dart';
import 'package:inventory_management_admin_pannel/features/Authentication/bloc/auth_bloc.dart';
import 'package:inventory_management_admin_pannel/features/Authentication/bloc/auth_event.dart';
import 'package:inventory_management_admin_pannel/features/dashboard/screens/dashboard_screen.dart';
import 'package:inventory_management_admin_pannel/features/user_management/screen/usermanagement_screen.dart';
import 'package:go_router/go_router.dart';

class NavbarScreen extends StatefulWidget {
  NavbarScreen({super.key, required this.child});

  Widget child;

  @override
  State<NavbarScreen> createState() => _NavbarScreenState();
}

class _NavbarScreenState extends State<NavbarScreen> {
  int selectedIndex = 0;

  final List<Widget> pages = [
    DashboardScreen(),
    UsermanagementScreen(),

    DepartmentManagementScreen(), // Suppliers
    MaterialManagementScreen(), // Purchase Orders
    PartyManagementScreen(), // Reports
  ];

  final GlobalKey _menuKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final username = TokenServices().username ?? "User";

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.blue,
        title: Row(
          children: [
            const Text(
              "Inventory Management",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            Container(
              margin: const EdgeInsets.only(left: 16),
              height: 45,
              width: 90,
              child: Image.asset(
                AssetUrl.icUnimeshTechnology,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            key: _menuKey,
            icon: const Icon(Icons.person, color: Colors.white),
            onPressed: () async {
              final button =
                  _menuKey.currentContext!.findRenderObject() as RenderBox;
              final overlay =
                  Overlay.of(context).context.findRenderObject() as RenderBox;

              final position = button.localToGlobal(
                Offset.zero,
                ancestor: overlay,
              );

              await showMenu(
                context: context,
                position: RelativeRect.fromLTRB(
                  position.dx,
                  position.dy + button.size.height,
                  overlay.size.width - position.dx,
                  0,
                ),
                items: [
                  PopupMenuItem(
                    enabled: false,
                    child: Text(username, style: TextStyle(fontSize: 14)),
                  ),
                  PopupMenuItem(
                    child: ListTile(
                      leading: const Icon(Icons.logout),
                      title: const Text("Logout"),
                      onTap: () async {
                        Navigator.pop(context);

                        await TokenServices().clear();

                        if (context.mounted) {
                          context.read<AuthBloc>().add(LogoutEvent());
                        }

                        context.goNamed(Routes.signin.name);
                      },
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(width: 10),
        ],
      ),

      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.blue),
              child: Column(
                children: [
                  //
                  Image.asset(AssetUrl.icUnimeshTechnology, height: 60),
                  const SizedBox(height: 12),
                  const Text(
                    "Inventory Management",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
            ),

            _drawerItem(
              context,
              "Dashboard",
              Icons.dashboard,
              Routes.dashboard.name,
            ),
            _drawerItem(
              context,
              "User Management",
              Icons.admin_panel_settings,
              Routes.userManagement.name,
            ),
            _drawerItem(
              context,
              "Department Management",
              Icons.list,
              Routes.department.name,
            ),
            _drawerItem(
              context,
              "Material Management",
              Icons.inventory,
              Routes.materialManagement.name,
            ),
            _drawerItem(
              context,
              "Parties/Companies",
              Icons.receipt,
              Routes.party.name,
            ),

            // _drawerItem("Settings", Icons.settings, 6),
          ],
        ),
      ),

      body: widget.child,
    );
  }

  Widget _drawerItem(
    BuildContext context,
    String label,
    IconData icon,
    String routeName,
  ) {
    final isSelected =
        GoRouter.of(context).routeInformationProvider.value.uri.path ==
        GoRouter.of(context).namedLocation(routeName);

    return ListTile(
      leading: Icon(icon, color: isSelected ? Colors.blue : null),
      title: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.blue : Colors.black,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      selected: isSelected,
      onTap: () {
        context.goNamed(routeName); // ✅ URL changes
        Navigator.pop(context);
      },
    );
  }
}
