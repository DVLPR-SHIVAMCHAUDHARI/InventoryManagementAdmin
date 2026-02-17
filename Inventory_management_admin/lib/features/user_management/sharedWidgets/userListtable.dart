import 'package:flutter/material.dart';

class UserListTable extends StatelessWidget {
  final List<dynamic> users;

  const UserListTable({super.key, required this.users});

  String _safe(dynamic value) {
    if (value == null) return "";
    return value.toString();
  }

  String _yesNo(dynamic value) {
    if (value == 1 || value == "1" || value == true) return "Yes";
    return "No";
  }

  @override
  Widget build(BuildContext context) {
    if (users.isEmpty) {
      return const Center(child: Text("No users found"));
    }

    return DataTable(
      headingRowColor: WidgetStatePropertyAll(Colors.blue.shade50),
      columnSpacing: 40,
      border: TableBorder.all(color: Colors.grey.shade300, width: 0.4),

      columns: const [
        DataColumn(label: Text("ID")),
        DataColumn(label: Text("Full Name")),
        DataColumn(label: Text("Email")),
        DataColumn(label: Text("Role ID")),
        DataColumn(label: Text("Role Name")),
        DataColumn(label: Text("Created At")),
        DataColumn(label: Text("Created By")),
        DataColumn(label: Text("Deleted")),
        DataColumn(label: Text("Verified")),
        DataColumn(label: Text("Updated At")),
        DataColumn(label: Text("Updated By")),
      ],

      rows: users.map<DataRow>((u) {
        // ✅ NO CASTING → works for JsonMap, LinkedHashMap, Map, etc.
        final user = u as dynamic;

        return DataRow(
          cells: [
            DataCell(Text(_safe(user["id"]))),
            DataCell(Text(_safe(user["fullname"]))),
            DataCell(Text(_safe(user["email"]))),
            DataCell(Text(_safe(user["role_id"]))),
            DataCell(Text(_safe(user["role_name"]))),
            DataCell(Text(_safe(user["created_at"]))),
            DataCell(Text(_safe(user["created_by"]))),
            DataCell(Text(_yesNo(user["is_deleted"]))),
            DataCell(Text(_yesNo(user["is_verified"]))),
            DataCell(Text(_safe(user["updated_at"]))),
            DataCell(Text(_safe(user["updated_by"]))),
          ],
        );
      }).toList(),
    );
  }
}
