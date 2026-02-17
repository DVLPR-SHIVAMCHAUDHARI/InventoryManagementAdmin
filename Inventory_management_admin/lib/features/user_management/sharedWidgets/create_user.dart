import 'package:inventory_management_admin_pannel/core/widgets/appdropdown.dart';
import 'package:inventory_management_admin_pannel/features/master_api/department/bloc/department_bloc.dart';
import 'package:inventory_management_admin_pannel/features/master_api/department/bloc/department_event.dart';
import 'package:inventory_management_admin_pannel/features/master_api/department/bloc/department_state.dart';
import 'package:inventory_management_admin_pannel/features/master_api/models/department_model.dart';

import 'package:inventory_management_admin_pannel/features/master_api/repositories/masterrepo.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_management_admin_pannel/features/user_management/bloc/user_management_bloc.dart';
import 'package:inventory_management_admin_pannel/features/user_management/bloc/user_management_event.dart';
import 'package:inventory_management_admin_pannel/features/user_management/bloc/user_management_state.dart';

class CreateUser extends StatefulWidget {
  const CreateUser({super.key});

  @override
  State<CreateUser> createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {
  DepartmentModel? _selectedDepartment;
  RoleModel? _selectedRole;

  final List<RoleModel> roles = [
    RoleModel(roleId: 2, roleName: "Admin"),
    RoleModel(roleId: 3, roleName: "Staff"),
  ];

  final _formKey = GlobalKey<FormState>();

  final fullnameController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final confirmPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserManagementBloc, UserManagementState>(
      listener: (context, state) {
        if (state is CreateUserSuccess) {
          fullnameController.clear();
          emailController.clear();
          passController.clear();
          confirmPassController.clear();
          setState(() {
            _selectedDepartment = null;

            _selectedRole = null;
          });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.green,
            ),
          );
        }

        if (state is CreateUserFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error), backgroundColor: Colors.red),
          );
        }
      },
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) =>
                DepartmentBloc(MasterRepo())..add(FetchDepartments()),
          ),
        ],
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Create New User",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// LEFT SIDE
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Full Name"),
                        const SizedBox(height: 6),
                        TextFormField(
                          controller: fullnameController,
                          validator: (v) =>
                              v!.isEmpty ? "Enter full name" : null,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                        ),

                        const SizedBox(height: 20),

                        const Text("Email"),
                        const SizedBox(height: 6),
                        TextFormField(
                          controller: emailController,
                          validator: (v) => v!.isEmpty ? "Enter email" : null,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                        ),

                        const SizedBox(height: 20),

                        const Text("Password"),
                        const SizedBox(height: 6),
                        TextFormField(
                          controller: passController,
                          obscureText: true,
                          validator: (v) =>
                              v!.length < 8 ? "Min 8 characters" : null,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                        ),

                        const SizedBox(height: 20),

                        const Text("Confirm Password"),
                        const SizedBox(height: 6),
                        TextFormField(
                          controller: confirmPassController,
                          obscureText: true,
                          validator: (v) => v != passController.text
                              ? "Passwords don't match"
                              : null,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 20),

                  /// RIGHT SIDE
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppDropdown<RoleModel>(
                          title: "Select Role",
                          hint: "Choose Role",
                          items: roles,
                          value: _selectedRole,
                          itemLabel: (r) => r.roleName!,
                          onChanged: (v) => setState(() => _selectedRole = v),
                        ),

                        const SizedBox(height: 24),

                        BlocBuilder<DepartmentBloc, DepartmentState>(
                          builder: (context, state) {
                            if (state is DepartmentLoading) {
                              return AppDropdownShimmer(title: "Department");
                            }

                            if (state is DepartmentLoaded) {
                              return AppDropdown<DepartmentModel>(
                                title: "Select Department",
                                hint: "Choose Department",
                                items: state.departments,
                                value: _selectedDepartment,
                                itemLabel: (d) => d.name,
                                onChanged: (v) =>
                                    setState(() => _selectedDepartment = v),
                              );
                            }

                            return const SizedBox.shrink();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              BlocBuilder<UserManagementBloc, UserManagementState>(
                builder: (context, state) {
                  return FilledButton(
                    onPressed: state is CreateUserLoading
                        ? null
                        : () {
                            if (!_formKey.currentState!.validate()) return;

                            if (_selectedRole == null ||
                                _selectedDepartment == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "Please select all dropdown fields",
                                  ),
                                  backgroundColor: Colors.red,
                                ),
                              );
                              return;
                            }

                            context.read<UserManagementBloc>().add(
                              UserSignUpEvent(
                                fullname: fullnameController.text.trim(),
                                email: emailController.text.trim(),
                                password: passController.text.trim(),
                                departmentId: _selectedDepartment!.id
                                    .toString(),

                                roleId: _selectedRole!.roleId!,
                              ),
                            );
                          },
                    child: state is CreateUserLoading
                        ? const SizedBox(
                            height: 18,
                            width: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text(
                            "Create User",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RoleModel {
  int? roleId;
  String? roleName;

  RoleModel({this.roleId, this.roleName});
}
