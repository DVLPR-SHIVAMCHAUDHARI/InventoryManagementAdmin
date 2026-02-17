import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_management_admin_pannel/features/user_management/bloc/user_management_bloc.dart';
import 'package:inventory_management_admin_pannel/features/user_management/bloc/user_management_event.dart';
import 'package:inventory_management_admin_pannel/features/user_management/bloc/user_management_state.dart';

import 'package:inventory_management_admin_pannel/features/user_management/repository/user_management_repository.dart';
import 'package:inventory_management_admin_pannel/features/user_management/sharedWidgets/create_user.dart';
import 'package:inventory_management_admin_pannel/features/user_management/sharedWidgets/delete_user.dart';
import 'package:inventory_management_admin_pannel/features/user_management/sharedWidgets/un_verify_user.dart';
import 'package:inventory_management_admin_pannel/features/user_management/sharedWidgets/update_user.dart';
import 'package:inventory_management_admin_pannel/features/user_management/sharedWidgets/update_user_password.dart';
import 'package:inventory_management_admin_pannel/features/user_management/sharedWidgets/userListtable.dart';
import 'package:inventory_management_admin_pannel/features/user_management/sharedWidgets/verify_user.dart';

class UsermanagementScreen extends StatefulWidget {
  const UsermanagementScreen({super.key});

  @override
  State<UsermanagementScreen> createState() => _UsermanagementScreenState();
}

class _UsermanagementScreenState extends State<UsermanagementScreen> {
  String selectedSortBy = "id";
  String selectedOrderBy = "asc";
  int currentPage = 1;
  int pageSize = 10; // API limit
  int totalCount = 0;
  final List<int> pageSizeOptions = [10, 25, 50];

  final List<String> sortByOptions = [
    "id",
    "email",
    "role_id",
    "fullname",
    "role_name",
    "created_at",
    "created_by",
    "is_deleted",
    "is_verfied",
    "updated_at",
    "updated_by",
  ];

  final List<String> orderByOptions = ["asc", "desc"];

  String selectedAction = "Create User";

  final List<String> actions = [
    "Create User",
    "Delete User",
    "Update User/ Password",
    "Verify/Un-Verify User",
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (context) =>
          UserManagementBloc(UserManagementRepo())..add(FetchUserListEvent()),

      child: Scaffold(
        backgroundColor: const Color(0xFFF5F7FB),
        body: LayoutBuilder(
          builder: (context, constraints) {
            double maxWidth = constraints.maxWidth;

            // Limit content width for large screens
            double contentWidth = maxWidth > 1200 ? 1200 : maxWidth * 0.95;

            return SingleChildScrollView(
              child: Container(
                width: width,
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// TITLE
                    Text(
                      "User Management",
                      style: TextStyle(
                        fontSize: contentWidth * 0.018,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey[900],
                      ),
                    ),

                    const SizedBox(height: 12),
                    const Divider(),
                    const SizedBox(height: 30),

                    /// ACTION DROPDOWN
                    Row(
                      children: [
                        Text(
                          "Select Action:",
                          style: TextStyle(
                            fontSize: contentWidth * 0.012,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 20),

                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: DropdownButton<String>(
                            value: selectedAction,
                            underline: SizedBox(),
                            items: actions
                                .map(
                                  (action) => DropdownMenuItem(
                                    value: action,
                                    child: Text(action),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              setState(() => selectedAction = value!);
                            },
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    /// FORM CARD
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 8,
                            color: Colors.black12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Builder(
                        builder: (context) {
                          return _buildActionWidget();
                        },
                      ),
                    ),

                    const SizedBox(height: 30),

                    /// USER TABLE CARD
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 8,
                            color: Colors.black12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              /// TITLE
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "User List",
                                  style: TextStyle(
                                    fontSize: contentWidth * 0.017,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),

                              /// SORT + ORDER + SEARCH
                              Row(
                                children: [
                                  /// SORT BY
                                  DropdownButton<String>(
                                    value: selectedSortBy,
                                    items: sortByOptions
                                        .map(
                                          (e) => DropdownMenuItem(
                                            value: e,
                                            child: Text("Sort: $e"),
                                          ),
                                        )
                                        .toList(),
                                    onChanged: (value) {
                                      setState(() => selectedSortBy = value!);

                                      context.read<UserManagementBloc>().add(
                                        FetchUserListEvent(
                                          sortBy: selectedSortBy,
                                          orderBy: selectedOrderBy,
                                        ),
                                      );
                                    },
                                  ),

                                  const SizedBox(width: 10),

                                  /// ORDER BY
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

                                      context.read<UserManagementBloc>().add(
                                        FetchUserListEvent(
                                          sortBy: selectedSortBy,
                                          orderBy: selectedOrderBy,
                                        ),
                                      );
                                    },
                                  ),

                                  const SizedBox(width: 10),
                                  DropdownButton<int>(
                                    value: pageSize,
                                    items: pageSizeOptions
                                        .map(
                                          (e) => DropdownMenuItem(
                                            value: e,
                                            child: Text("Show $e"),
                                          ),
                                        )
                                        .toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        pageSize = value!;
                                        currentPage = 1;
                                      });

                                      context.read<UserManagementBloc>().add(
                                        FetchUserListEvent(
                                          offset: currentPage,
                                          limit: pageSize,
                                          sortBy: selectedSortBy,
                                          orderBy: selectedOrderBy,
                                        ),
                                      );
                                    },
                                  ),

                                  const SizedBox(width: 10),

                                  /// SEARCH BAR
                                  SizedBox(
                                    width: contentWidth * 0.3,
                                    child: SearchBar(
                                      backgroundColor: WidgetStatePropertyAll(
                                        Colors.white,
                                      ),
                                      padding: WidgetStatePropertyAll(
                                        EdgeInsets.symmetric(horizontal: 12),
                                      ),
                                      shape: WidgetStatePropertyAll(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          side: BorderSide(
                                            color: Colors.grey.shade300,
                                          ),
                                        ),
                                      ),
                                      textStyle: WidgetStatePropertyAll(
                                        TextStyle(
                                          fontSize: contentWidth * 0.012,
                                        ),
                                      ),
                                      hintText:
                                          "🔍 Search by Email or Full Name",
                                      onChanged: (value) {
                                        context.read<UserManagementBloc>().add(
                                          FetchUserListEvent(
                                            email: value,
                                            fullname: value,
                                            sortBy: selectedSortBy,
                                            orderBy: selectedOrderBy,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: BlocBuilder<UserManagementBloc, UserManagementState>(
                              builder: (context, state) {
                                if (state is UserListLoading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }

                                if (state is UserListLoaded) {
                                  final List users = state.users["list"] ?? [];
                                  totalCount = state.users["count"] ?? 0;

                                  final int totalPages = (totalCount / pageSize)
                                      .ceil();

                                  return Column(
                                    children: [
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: UserListTable(users: users),
                                      ),

                                      const SizedBox(height: 12),

                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            "Page $currentPage of $totalPages",
                                          ),
                                          const SizedBox(width: 12),

                                          IconButton(
                                            onPressed: currentPage > 1
                                                ? () {
                                                    setState(
                                                      () => currentPage--,
                                                    );

                                                    context
                                                        .read<
                                                          UserManagementBloc
                                                        >()
                                                        .add(
                                                          FetchUserListEvent(
                                                            offset: currentPage,
                                                            limit: pageSize,
                                                            sortBy:
                                                                selectedSortBy,
                                                            orderBy:
                                                                selectedOrderBy,
                                                          ),
                                                        );
                                                  }
                                                : null,
                                            icon: const Icon(
                                              Icons.chevron_left,
                                            ),
                                          ),

                                          IconButton(
                                            onPressed: currentPage < totalPages
                                                ? () {
                                                    setState(
                                                      () => currentPage++,
                                                    );

                                                    context
                                                        .read<
                                                          UserManagementBloc
                                                        >()
                                                        .add(
                                                          FetchUserListEvent(
                                                            offset: currentPage,
                                                            limit: pageSize,
                                                            sortBy:
                                                                selectedSortBy,
                                                            orderBy:
                                                                selectedOrderBy,
                                                          ),
                                                        );
                                                  }
                                                : null,
                                            icon: const Icon(
                                              Icons.chevron_right,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                }

                                if (state is UserListFailure) {
                                  return Center(
                                    child: Text("Error: ${state.error}"),
                                  );
                                }

                                return const SizedBox();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  /// Dynamic Form Section
  Widget _buildActionWidget() {
    switch (selectedAction) {
      case "Create User":
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Expanded(child: CreateUser())],
        );
      case "Delete User":
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Expanded(child: DeleteUser())],
        );

      case "Update User/ Password":
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: UpdateUser()),

            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              height: 500,
              child: VerticalDivider(color: Colors.grey.shade300),
            ),

            Expanded(child: UpdateUserPassword()),
          ],
        );

      case "Verify/Un-Verify User":
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: VerifyUser()),

            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              height: 500,
              child: VerticalDivider(color: Colors.grey.shade300),
            ),

            Expanded(child: UnVerifyUser()),
          ],
        );

      default:
        return SizedBox();
    }
  }
}
