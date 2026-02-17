import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ManagementScreen extends StatefulWidget {
  const ManagementScreen({super.key});

  @override
  State<ManagementScreen> createState() => _ManagementScreenState();
}

class _ManagementScreenState extends State<ManagementScreen> {
  /// TABLE CONTROLS
  String selectedSortBy = "id";
  String selectedOrderBy = "asc";
  int currentPage = 1;
  int pageSize = 10;
  int totalCount = 0;

  final List<int> pageSizeOptions = [10, 25, 50];
  final List<String> sortByOptions = ["id", "name", "created_at", "updated_at"];
  final List<String> orderByOptions = ["asc", "desc"];

  /// ACTION CONTROLS
  String selectedAction = "Create";

  final List<String> actions = ["Create", "Update", "Delete", "Verify"];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// TITLE
              Text(
                "Management Screen",
                style: TextStyle(
                  fontSize: width * 0.018,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),
              const Divider(),
              const SizedBox(height: 24),

              /// ACTION SELECTOR
              Row(
                children: [
                  const Text(
                    "Select Action:",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(width: 20),
                  _buildActionDropdown(),
                ],
              ),

              const SizedBox(height: 30),

              /// FORM CARD
              _buildCard(child: _buildActionWidget()),

              const SizedBox(height: 30),

              /// TABLE CARD
              _buildCard(
                child: Column(
                  children: [
                    _buildTableHeader(),
                    const SizedBox(height: 12),
                    _buildTable(),
                    const SizedBox(height: 12),
                    _buildPagination(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// ACTION DROPDOWN
  Widget _buildActionDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: DropdownButton<String>(
        value: selectedAction,
        underline: const SizedBox(),
        items: actions
            .map((a) => DropdownMenuItem(value: a, child: Text(a)))
            .toList(),
        onChanged: (value) {
          setState(() => selectedAction = value!);
        },
      ),
    );
  }

  /// DYNAMIC FORM AREA
  Widget _buildActionWidget() {
    switch (selectedAction) {
      case "Create":
        return const Placeholder(fallbackHeight: 200);
      case "Update":
        return const Placeholder(fallbackHeight: 200);
      case "Delete":
        return const Placeholder(fallbackHeight: 200);
      case "Verify":
        return const Placeholder(fallbackHeight: 200);
      default:
        return const SizedBox();
    }
  }

  /// TABLE HEADER (SORT / SEARCH)
  Widget _buildTableHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "List",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            DropdownButton<String>(
              value: selectedSortBy,
              items: sortByOptions
                  .map(
                    (e) => DropdownMenuItem(value: e, child: Text("Sort: $e")),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() => selectedSortBy = value!);
              },
            ),
            const SizedBox(width: 10),
            DropdownButton<String>(
              value: selectedOrderBy,
              items: orderByOptions
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text(e.toUpperCase()),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() => selectedOrderBy = value!);
              },
            ),
            const SizedBox(width: 10),
            DropdownButton<int>(
              value: pageSize,
              items: pageSizeOptions
                  .map(
                    (e) => DropdownMenuItem(value: e, child: Text("Show $e")),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  pageSize = value!;
                  currentPage = 1;
                });
              },
            ),
            const SizedBox(width: 10),
            SizedBox(
              width: 250,
              child: SearchBar(hintText: "Search...", onChanged: (value) {}),
            ),
          ],
        ),
      ],
    );
  }

  /// TABLE PLACEHOLDER
  Widget _buildTable() {
    return const SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Placeholder(fallbackHeight: 250),
    );
  }

  /// PAGINATION
  Widget _buildPagination() {
    final totalPages = (totalCount / pageSize).ceil().clamp(1, 999);

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text("Page $currentPage of $totalPages"),
        IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: currentPage > 1
              ? () => setState(() => currentPage--)
              : null,
        ),
        IconButton(
          icon: const Icon(Icons.chevron_right),
          onPressed: currentPage < totalPages
              ? () => setState(() => currentPage++)
              : null,
        ),
      ],
    );
  }

  /// CARD DECORATION
  Widget _buildCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(blurRadius: 8, color: Colors.black12, offset: Offset(0, 4)),
        ],
      ),
      child: child,
    );
  }
}
