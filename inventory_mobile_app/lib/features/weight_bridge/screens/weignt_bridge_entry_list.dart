import 'package:flutter/material.dart';
import 'package:inventory_mobile_app/core/consts/appcolors.dart';
import 'package:inventory_mobile_app/core/routes/routes.dart';
import 'package:inventory_mobile_app/features/weight_bridge/models/pending_model.dart';

class WeighBridgeOutListPage extends StatelessWidget {
  const WeighBridgeOutListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.all(12),
          itemCount: pendingWeighBridgeOutList.length,
          separatorBuilder: (_, __) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            final item = pendingWeighBridgeOutList[index];

            return Card(
              color: AppColors.primaryLight,
              child: ListTile(
                title: Text(
                  '${item.partyName} • ${item.lorryNo}',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                subtitle: Text(
                  'Gate: ${item.gateId} | Invoice: ${item.invoiceNo}\n'
                  'Driver: ${item.driverName}',
                ),
                trailing: ElevatedButton(
                  onPressed: () {
                    _confirmMarkOut(context, item);
                  },
                  child: const Text('MARK OUT'),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // ---------------- CONFIRM POPUP ----------------

  void _confirmMarkOut(BuildContext context, WeighBridgePendingEntry item) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Confirm Weigh Bridge OUT'),
        content: Text(
          'Are you sure you want to mark OUT this vehicle?\n\n'
          'Lorry: ${item.lorryNo}\n'
          'Party: ${item.partyName}',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CANCEL'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);

              // ✅ Navigate AFTER confirmation
              router.pushNamed(
                Routes.weightBridgeExit.name,
                extra: item, // 👈 pass full object if needed
              );
            },
            child: const Text('YES, MARK OUT'),
          ),
        ],
      ),
    );
  }
}

final List<WeighBridgePendingEntry> pendingWeighBridgeOutList = [
  WeighBridgePendingEntry(
    gateId: 108,
    date: '02/01/2023',
    gateTime: '18:55',
    invoiceNo: '22-23/450',
    lorryNo: 'TN 88 W 3412',
    partyName: 'Bhuvaneswari Industries, Adoni',
    driverName: 'Gobi',
    driverMobile: '7373647753',
    materialName: 'Raw Cotton',
    grossWeight: 24580,
    wbInDate: '02/01/2023',
    wbInTime: '19:10',
  ),
  WeighBridgePendingEntry(
    gateId: 195,
    date: '16/01/2023',
    gateTime: '07:48',
    invoiceNo: 'AE22Y-00236',
    lorryNo: 'MH30 L 2970',
    partyName: 'Manjeet Cotton, Georai',
    driverName: 'Aspak',
    driverMobile: '0',
    materialName: 'Cotton Bales',
    grossWeight: 19840,
    wbInDate: '16/01/2023',
    wbInTime: '08:05',
  ),
  WeighBridgePendingEntry(
    gateId: 121,
    date: '18/01/2023',
    gateTime: '14:22',
    invoiceNo: 'INV-8891',
    lorryNo: 'KA 05 AB 1189',
    partyName: 'Shree Traders, Hubli',
    driverName: 'Ramesh',
    driverMobile: '9876543210',
    materialName: 'Packaging Material',
    grossWeight: 12360,
    wbInDate: '18/01/2023',
    wbInTime: '14:40',
  ),
];
