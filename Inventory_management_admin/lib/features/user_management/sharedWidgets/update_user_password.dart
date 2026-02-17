import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_management_admin_pannel/core/Utils/snack_bar.dart';
import 'package:inventory_management_admin_pannel/features/user_management/bloc/user_management_bloc.dart';
import 'package:inventory_management_admin_pannel/features/user_management/bloc/user_management_event.dart';
import 'package:inventory_management_admin_pannel/features/user_management/bloc/user_management_state.dart';

class UpdateUserPassword extends StatefulWidget {
  const UpdateUserPassword({super.key});

  @override
  State<UpdateUserPassword> createState() => _UpdateUserPasswordState();
}

class _UpdateUserPasswordState extends State<UpdateUserPassword> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController idController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserManagementBloc, UserManagementState>(
      listener: (context, state) {
        if (state is UpdatePasswordSuccess) {
          snackbar(
            context,
            color: Colors.green,
            message: state.message,
            title: 'Great',
            type: ContentType.success,
          );
          idController.clear();
          passController.clear();
          confirmPassController.clear();
        }
        if (state is UpdatePasswordFailure) {
          snackbar(
            context,
            color: Colors.red,
            message: state.error,
            title: 'Oops',
            type: ContentType.failure,
          );
        }
      },
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Title
            const Text(
              "Update User Password",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),

            // USER ID
            const Text(
              "User ID",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 6),

            TextFormField(
              controller: idController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Enter user ID";
                }
                if (int.tryParse(value) == null) {
                  return "ID must be a number";
                }
                return null;
              },
              decoration: const InputDecoration(
                hintText: "Enter numeric User ID",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            // PASSWORD
            const Text(
              "New Password",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 6),

            TextFormField(
              controller: passController,
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Enter password";
                }
                if (value.length < 8) {
                  return "Password must be at least 8 characters";
                }
                return null;
              },
              decoration: const InputDecoration(
                hintText: "Enter new password",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            // CONFIRM PASSWORD
            const Text(
              "Confirm Password",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 6),

            TextFormField(
              controller: confirmPassController,
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Re-enter password";
                }
                if (value != passController.text) {
                  return "Passwords do not match";
                }
                return null;
              },
              decoration: const InputDecoration(
                hintText: "Re-enter new password",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 26),

            /// SUBMIT BUTTON
            BlocBuilder<UserManagementBloc, UserManagementState>(
              builder: (context, state) {
                return SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        int userId = int.parse(idController.text);
                        String newPassword = passController.text;

                        print("Updating password for user ID: $userId");
                        print("New Password: $newPassword");

                        // 🔥 Later: call BLoC event
                        context.read<UserManagementBloc>().add(
                          UpdatePasswordEvent(
                            userId: userId,
                            newPassword: newPassword,
                          ),
                        );
                      }
                    },
                    child: state is UpdatePasswordLoading
                        ? SizedBox(
                            height: 18,
                            width: 18,

                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : Text(
                            "Update Password",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
