import 'package:inventory_management_admin_pannel/features/Department%20Management/screens/department_management_screen.dart';
import 'package:inventory_management_admin_pannel/features/materialManagement/screens/material_management_screen.dart';
import 'package:inventory_management_admin_pannel/features/master_api/department/bloc/department_bloc.dart';
import 'package:inventory_management_admin_pannel/features/master_api/repositories/masterrepo.dart';
import 'package:inventory_management_admin_pannel/features/party_management/screens/party_management_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/web.dart';
import 'package:inventory_management_admin_pannel/features/Authentication/bloc/auth_bloc.dart';
import 'package:inventory_management_admin_pannel/features/Authentication/screens/sign_in_screen.dart';
import 'package:inventory_management_admin_pannel/features/dashboard/screens/dashboard_screen.dart';
import 'package:inventory_management_admin_pannel/features/navbar/navbarscreen.dart';
import 'package:inventory_management_admin_pannel/features/splashscreen/splashscreen.dart';
import 'package:inventory_management_admin_pannel/features/user_management/bloc/user_management_bloc.dart';
import 'package:inventory_management_admin_pannel/features/user_management/repository/user_management_repository.dart';
import 'package:inventory_management_admin_pannel/features/user_management/screen/usermanagement_screen.dart';

Logger logger = Logger();

enum Routes {
  splash,
  signin,
  dashboard,
  userManagement,
  department,
  materialManagement,
  party,
}

GoRouter router = GoRouter(
  routes: [
    /// SPLASH
    GoRoute(
      path: "/",
      name: Routes.splash.name,
      builder: (context, state) => const Splashscreen(),
    ),

    /// SIGN IN
    GoRoute(
      path: "/signin",
      name: Routes.signin.name,
      builder: (context, state) =>
          BlocProvider(create: (_) => AuthBloc(), child: SignInScreen()),
    ),

    /// SHELL (NAVBAR LAYOUT)
    ShellRoute(
      builder: (context, state, child) {
        return BlocProvider(
          create: (_) => AuthBloc(),
          child: NavbarScreen(child: child),
        );
      },
      routes: [
        /// DASHBOARD
        GoRoute(
          path: "/dashboard",
          name: Routes.dashboard.name,
          builder: (_, __) => const DashboardScreen(),
        ),

        /// USER MANAGEMENT
        GoRoute(
          path: "/user-management",
          name: Routes.userManagement.name,
          builder: (context, state) {
            return BlocProvider(
              create: (_) => UserManagementBloc(UserManagementRepo()),
              child: const UsermanagementScreen(),
            );
          },
        ),

        /// DEPARTMENT MANAGEMENT
        GoRoute(
          path: "/departments",
          name: Routes.department.name,
          builder: (context, state) {
            return BlocProvider(
              create: (_) => DepartmentBloc(MasterRepo()),
              child: const DepartmentManagementScreen(),
            );
          },
        ),

        /// BOX SIZE MANAGEMENT
        GoRoute(
          path: "/materialManagement",
          name: Routes.materialManagement.name,
          builder: (_, __) => const MaterialManagementScreen(),
        ),

        /// PARTY MANAGEMENT
        GoRoute(
          path: "/parties",
          name: Routes.party.name,
          builder: (_, __) => const PartyManagementScreen(),
        ),
      ],
    ),
  ],
);
