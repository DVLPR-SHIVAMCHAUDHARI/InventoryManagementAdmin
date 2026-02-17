import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:inventory_management_admin_pannel/core/widgets/appdropdown.dart';
import 'package:inventory_management_admin_pannel/features/master_api/department/bloc/department_bloc.dart';
import 'package:inventory_management_admin_pannel/features/master_api/department/bloc/department_event.dart';
import 'package:inventory_management_admin_pannel/features/master_api/department/bloc/department_state.dart';
import 'package:inventory_management_admin_pannel/features/master_api/models/department_model.dart';

import 'package:inventory_management_admin_pannel/features/master_api/repositories/masterrepo.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_management_admin_pannel/core/Utils/snack_bar.dart';
import 'package:inventory_management_admin_pannel/features/user_management/bloc/user_management_bloc.dart';
import 'package:inventory_management_admin_pannel/features/user_management/bloc/user_management_event.dart';
import 'package:inventory_management_admin_pannel/features/user_management/bloc/user_management_state.dart';

class UpdateUser extends StatefulWidget {
  const UpdateUser({super.key});

  @override
  State<UpdateUser> createState() => _UpdateUserState();
}

class _UpdateUserState extends State<UpdateUser> {
  final _formKey = GlobalKey<FormState>();

  final fullnameController = TextEditingController();
  final emailController = TextEditingController();
  final idController = TextEditingController();

  DepartmentModel? _selectedDepartment;

  RoleModel? _selectedRole;

  final List<RoleModel> roles = [
    RoleModel(roleId: 2, roleName: "Admin"),
    RoleModel(roleId: 3, roleName: "Staff"),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserManagementBloc, UserManagementState>(
      listener: (context, state) {
        if (state is UpdateUserSuccess) {
          fullnameController.clear();
          emailController.clear();
          idController.clear();
          setState(() {
            _selectedDepartment = null;

            _selectedRole = null;
          });

          snackbar(
            context,
            color: Colors.green,
            message: state.message,
            title: 'Success',
            type: ContentType.success,
          );
        }

        if (state is UpdateUserFailure) {
          snackbar(
            context,
            color: Colors.red,
            message: state.error,
            title: 'Error',
            type: ContentType.failure,
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
                "Update User",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),

              /// FULL NAME
              const Text("Full Name"),
              const SizedBox(height: 6),
              TextFormField(
                controller: fullnameController,
                validator: (v) =>
                    v == null || v.isEmpty ? "Enter full name" : null,
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),

              const SizedBox(height: 20),

              /// EMAIL
              const Text("Email"),
              const SizedBox(height: 6),
              TextFormField(
                controller: emailController,
                validator: (v) {
                  if (v == null || v.isEmpty) return "Enter email";
                  if (!RegExp(
                    r'^[\w\-.]+@([\w-]+\.)+[\w-]{2,4}$',
                  ).hasMatch(v)) {
                    return "Enter valid email";
                  }
                  return null;
                },
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),

              const SizedBox(height: 20),

              /// USER ID
              const Text("User ID"),
              const SizedBox(height: 6),
              TextFormField(
                controller: idController,
                keyboardType: TextInputType.number,
                validator: (v) {
                  if (v == null || v.isEmpty) return "Enter user ID";
                  if (int.tryParse(v) == null) return "Invalid user ID";
                  return null;
                },
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),

              const SizedBox(height: 24),

              /// ROLE
              AppDropdown<RoleModel>(
                title: "Select Role",
                hint: "Choose Role",
                items: roles,
                value: _selectedRole,
                itemLabel: (r) => r.roleName!,
                onChanged: (v) => setState(() => _selectedRole = v),
              ),

              const SizedBox(height: 24),

              /// DEPARTMENT
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
                      onChanged: (v) => setState(() => _selectedDepartment = v),
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),

              const SizedBox(height: 30),

              /// SUBMIT
              BlocBuilder<UserManagementBloc, UserManagementState>(
                builder: (context, state) {
                  return FilledButton(
                    onPressed: state is UpdateUserLoading
                        ? null
                        : () {
                            if (!_formKey.currentState!.validate()) return;

                            if (_selectedRole == null ||
                                _selectedDepartment == null) {
                              snackbar(
                                context,
                                color: Colors.red,
                                message: "Please select role and department",
                                title: "Required",
                                type: ContentType.failure,
                              );
                              return;
                            }

                            context.read<UserManagementBloc>().add(
                              UpdateUserEvent(
                                userId: int.parse(idController.text.trim()),
                                fullname: fullnameController.text.trim(),
                                email: emailController.text.trim(),
                                departmentId: _selectedDepartment!.id!,

                                roleId: _selectedRole!.roleId!,
                              ),
                            );
                          },
                    child: state is UpdateUserLoading
                        ? const SizedBox(
                            height: 18,
                            width: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text(
                            "Update User",
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
