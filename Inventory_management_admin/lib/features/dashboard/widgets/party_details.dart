import 'package:inventory_management_admin_pannel/features/dashboard/models/stage_summary_model.dart';
import 'package:flutter/material.dart';

class PartyDetailsCard extends StatelessWidget {
  final List<PartySummaryModel> parties;

  const PartyDetailsCard({super.key, required this.parties});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Container(
        height: 360, // ✅ FIXED HEIGHT FOR WEB
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Color(0x14000000),
              blurRadius: 12,
              offset: Offset(0, 6),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// HEADER (STATIC)
            Row(
              children: const [
                Icon(
                  Icons.groups_2_outlined,
                  size: 20,
                  color: Color(0xFF374151),
                ),
                SizedBox(width: 8),
                Text(
                  "Party Details",
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500, // ⬇️ reduced
                    color: Color(0xFF374151), // ⬇️ softer gray
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            /// SCROLLABLE LIST
            Expanded(
              child: ListView.separated(
                itemCount: parties.length,
                separatorBuilder: (_, __) =>
                    Divider(height: 22, color: Colors.grey.shade200),
                itemBuilder: (_, i) {
                  final p = parties[i];

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: MouseRegion(
                      cursor: SystemMouseCursors.basic,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 120),
                        curve: Curves.easeOut,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.03),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.grey.withOpacity(0.08),
                          ),
                        ),
                        child: Row(
                          children: [
                            /// LEFT ACCENT DOT
                            Container(
                              height: 8,
                              width: 8,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(
                                  context,
                                ).colorScheme.primary.withOpacity(0.6),
                              ),
                            ),

                            const SizedBox(width: 10),

                            /// PARTY NAME
                            Expanded(
                              child: Text(
                                p.partyName,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF374151),
                                ),
                              ),
                            ),

                            /// COUNT BADGE
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFFEFF6FF),
                                    Color(0xFFDDEAFE),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                "${p.totalBoxes} boxes",
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF2563EB),
                                ),
                              ),
                            ),
                          ],
                        ),
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
}
