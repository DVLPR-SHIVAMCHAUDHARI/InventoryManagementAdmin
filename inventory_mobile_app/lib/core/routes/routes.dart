import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:inventory_mobile_app/features/authentication/bloc/auth_bloc.dart';
import 'package:inventory_mobile_app/features/authentication/screens/login_screen.dart';

import 'package:inventory_mobile_app/features/gate_operations/gate_entries/screens/gate_entry_screen.dart';
import 'package:inventory_mobile_app/features/gate_operations/gate_exits/screens/gate_exit_screen.dart';

import 'package:inventory_mobile_app/features/gate_operations/screens/gate_operations_screen.dart';
import 'package:inventory_mobile_app/features/homescreen/pages/homescreen.dart';
import 'package:inventory_mobile_app/features/loading/screens/loading_screen.dart';
import 'package:inventory_mobile_app/features/operations/material_issue/screens/material_issue_screen.dart';
import 'package:inventory_mobile_app/features/operations/material_reciept/screens/material_receipt_screen.dart';
import 'package:inventory_mobile_app/features/operations/screens/staff_home_screen.dart';
import 'package:inventory_mobile_app/features/operations/stock_transfer/screens/stock_transfer_screen.dart';
import 'package:inventory_mobile_app/features/splash/screens/splashscreen.dart';
import 'package:inventory_mobile_app/features/unloading/screens/unloading_screen.dart';
import 'package:inventory_mobile_app/features/weight_bridge/screens/Weight_bridge_screen.dart';
import 'package:inventory_mobile_app/features/weight_bridge/screens/weigt_bridge_exit.dart';

enum Routes {
  splash,
  login,
  unloadingPage,
  loadingPage,
  gateOperations,
  gateEntry,
  materialReceipt,
  materialIssue,
  stockTransfer,
  staffHome,
  settings,
  addInventory,
  editInventory,
  notifications,
  helpCenter,
  weightBridge,
  weightBridgeExit,
  homeScreen,
  gateExit,
  // updateGateEntry,
}

GoRouter router = GoRouter(
  // initialLocation: "/homeScreen",
  routes: [
    GoRoute(
      path: "/",
      name: Routes.splash.name,
      builder: (context, state) {
        return const Splashscreen();
      },
    ),
    GoRoute(
      path: "/login",
      name: Routes.login.name,
      builder: (context, state) {
        return BlocProvider(
          create: (context) => AuthBloc(),
          child: LoginScreen(),
        );
      },
    ),
    GoRoute(
      path: "/UnloadingPage",
      name: Routes.unloadingPage.name,
      builder: (context, state) {
        return UnloadingPage();
      },
    ),
    GoRoute(
      path: "/loadingPage",
      name: Routes.loadingPage.name,
      builder: (context, state) {
        return LoadingScreen();
      },
    ),
    GoRoute(
      path: "/gateOperations",
      name: Routes.gateOperations.name,
      builder: (context, state) {
        return GateOperationsPage();
      },
    ),
    GoRoute(
      path: "/gateEntry",
      name: Routes.gateEntry.name,
      builder: (context, state) {
        return GateEntryScreen();
      },
    ),
    GoRoute(
      path: "/gateExit",
      name: Routes.gateExit.name,
      builder: (context, state) {
        return GateExitScreen();
      },
    ),
    GoRoute(
      path: "/weight-Bridge",
      name: Routes.weightBridge.name,

      builder: (context, state) {
        return WeightBridgeScreen();
      },
    ),
    GoRoute(
      path: "/weightBridgeExit",
      name: Routes.weightBridgeExit.name,

      builder: (context, state) {
        return WeighBridgeExitPage();
      },
    ),
    GoRoute(
      path: "/materialReceipt",
      name: Routes.materialReceipt.name,
      builder: (context, state) {
        return MaterialReceiptPage();
      },
    ),
    GoRoute(
      path: "/materialIssue",
      name: Routes.materialIssue.name,
      builder: (context, state) {
        return MaterialIssuePage();
      },
    ),
    GoRoute(
      path: "/stockTransfer",
      name: Routes.stockTransfer.name,
      builder: (context, state) {
        return StockTransferPage();
      },
    ),
    GoRoute(
      path: "/staffHome",
      name: Routes.staffHome.name,
      builder: (context, state) {
        return StaffHomePage();
      },
    ),
    GoRoute(
      path: "/homeScreen",
      name: Routes.homeScreen.name,
      builder: (context, state) {
        return BlocProvider(create: (context) => AuthBloc(), child: HomePage());
      },
    ),
  ],
);
