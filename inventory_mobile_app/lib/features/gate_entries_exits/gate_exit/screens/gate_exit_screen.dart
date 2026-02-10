import 'package:flutter/material.dart';

import 'package:inventory_mobile_app/core/consts/appcolors.dart';

import 'package:inventory_mobile_app/features/gate_entries_exits/models/gate_Entry_model.dart';

class GateExitPage extends StatefulWidget {
  const GateExitPage({super.key});

  @override
  State<GateExitPage> createState() => _GateExitPageState();
}

class _GateExitPageState extends State<GateExitPage> {
  final list = gateExitList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // 👇 THIS Expanded IS CRITICAL
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(12),
                itemCount: list.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final item = list[index];

                  return Card(
                    elevation: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.partyName,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Gate: ${item.gateId} | Invoice: ${item.invoiceNo}',
                          ),
                          Text('Lorry: ${item.lorryNo}'),
                          Text(
                            'Driver: ${item.driverName} (${item.driverMobile})',
                          ),
                          const SizedBox(height: 8),
                          Align(
                            alignment: Alignment.centerRight,
                            child: item.isExited
                                ? const Chip(label: Text('Exited'))
                                : ElevatedButton(
                                    onPressed: () =>
                                        _confirmExit(context, index),
                                    child: const Text('EXIT'),
                                  ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmExit(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Confirm Exit'),
        content: const Text(
          'Are you sure you want to mark this vehicle as exited?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CANCEL'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                list[index] = GateExitEntry(
                  gateId: list[index].gateId,
                  date: list[index].date,
                  gateTime: list[index].gateTime,
                  invoiceNo: list[index].invoiceNo,
                  lorryNo: list[index].lorryNo,
                  partyName: list[index].partyName,
                  driverName: list[index].driverName,
                  driverMobile: list[index].driverMobile,
                  isExited: true,
                );
              });
            },
            child: const Text('YES, EXIT'),
          ),
        ],
      ),
    );
  }
}

final List<GateExitEntry> gateExitList = [
  GateExitEntry(
    gateId: 1,
    date: '16-12-2022',
    gateTime: '22:34',
    invoiceNo: 'Cs-36',
    lorryNo: 'MH30L 2970',
    partyName: 'GAJANAND COTTEX PVT.LTD GUJRAT',
    driverName: 'Munnabhai',
    driverMobile: '0',
    isExited: false,
  ),
  GateExitEntry(
    gateId: 6,
    date: '19-12-2022',
    gateTime: '11:20',
    invoiceNo: '109',
    lorryNo: 'MH20DE 4737',
    partyName: 'AnandCott Ginn Gangapur',
    driverName: 'Sajid',
    driverMobile: '8788102246',
    isExited: false,
  ),
  GateExitEntry(
    gateId: 54,
    date: '26-12-2022',
    gateTime: '16:30',
    invoiceNo: 'Sseed/222/173',
    lorryNo: 'MH23 5190',
    partyName: 'Shri Rokadaba Maharaj Ginning Pressing',
    driverName: 'Munnabhai',
    driverMobile: '0',
    isExited: true, // already exited
  ),
];
