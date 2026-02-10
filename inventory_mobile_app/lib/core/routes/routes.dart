import 'package:go_router/go_router.dart';
import 'package:inventory_mobile_app/features/authentication/screens/login_screen.dart';
import 'package:inventory_mobile_app/features/gate_entries_exits/screens/gate_entry_exit_screen.dart';
import 'package:inventory_mobile_app/features/homescreen/pages/homescreen.dart';
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
  gateEntryExit,
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
        return LoginScreen();
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
      path: "/gate-entry-exit",
      name: Routes.gateEntryExit.name,
      builder: (context, state) {
        return GateOperationsPage();
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
        return HomePage();
      },
    ),
  ],
);
