import 'package:inventory_management_admin_pannel/features/dashboard/models/history_model.dart';
import 'package:flutter/material.dart';

class HistoryView extends StatelessWidget {
  final List<HistoryModel> history;

  const HistoryView({required this.history});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: history.map((h) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x14000000),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      /// STAGE 1 FROM
                      _HistoryStep(
                        icon: Icons.warehouse,
                        title: h.firstStageFromDepartment,
                        subtitle: "Assigned by ${h.firstStageFromUser}",
                        time: h.firstStageFromDateTime,
                        color: Colors.blue,
                      ),

                      if (h.firstStageToUser != null) ...[
                        _Arrow(),

                        /// STAGE 1 TO
                        ///
                        _HistoryStep(
                          icon: Icons.hub_outlined,
                          title: h.firstStageToDepartment,
                          subtitle: "Received by ${h.firstStageToUser}",
                          time: "${h.firstStageToDate}${h.firstStageToTime}",
                          color: Colors.green,
                        ),
                      ],

                      _Arrow(),
                      if (h.assignedToPartyName != null) ...[
                        /// PARTY
                        _HistoryStep(
                          icon: Icons.business,
                          title: h.assignedToPartyName,
                          subtitle: h.assignedToCompanyAddress,
                          time: h.stillAssignedSecond == 0
                              ? "Released"
                              : "Still Assigned",
                          color: Colors.orange,
                        ),
                      ],

                      /// STAGE 2 (ONLY IF EXISTS)
                      if (h.secondStageToDepartment != null) ...[
                        _Arrow(),

                        _HistoryStep(
                          icon: Icons.warehouse,
                          title: h.secondStageToDepartment,
                          subtitle: "Assigned by ${h.secondStageToUser}",
                          time: "${h.secondStageToDate} ${h.secondStageToTime}",
                          color: Colors.blue,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class _HistoryStep extends StatelessWidget {
  final IconData icon;
  final String? title;
  final String? subtitle;
  final String? time;
  final Color color;

  const _HistoryStep({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 22,
          backgroundColor: color.withOpacity(0.15),
          child: Icon(icon, color: color, size: 22),
        ),
        const SizedBox(height: 8),

        SizedBox(
          width: 160,
          child: Column(
            children: [
              Text(
                title ?? "-",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle ?? "",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 11, color: Colors.black54),
              ),
              const SizedBox(height: 4),
              Text(
                time ?? "-",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 10, color: Colors.black38),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Arrow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Colors.grey.shade400,
      ),
    );
  }
}
