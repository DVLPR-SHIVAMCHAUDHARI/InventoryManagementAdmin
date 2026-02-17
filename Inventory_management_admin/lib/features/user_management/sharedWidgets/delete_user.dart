import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_management_admin_pannel/core/Utils/snack_bar.dart';
import 'package:inventory_management_admin_pannel/features/user_management/bloc/user_management_bloc.dart';
import 'package:inventory_management_admin_pannel/features/user_management/bloc/user_management_event.dart';
import 'package:inventory_management_admin_pannel/features/user_management/bloc/user_management_state.dart';

class DeleteUser extends StatelessWidget {
  DeleteUser({super.key});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController idController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserManagementBloc, UserManagementState>(
      listener: (context, state) {
        if (state is DeleteUserSuccess) {
          snackbar(
            context,
            color: Colors.green,
            message: state.message,
            title: 'Great',
            type: ContentType.success,
          );
          idController.clear();
        }
        if (state is DeleteUserFailure) {
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
              "Delete User",
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
              keyboardType: TextInputType.number,

              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Enter User ID";
                }
                if (int.tryParse(value) == null) {
                  return "User ID must be a valid number";
                }
                return null;
              },
              decoration: const InputDecoration(
                hintText: "Enter numeric User ID",
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
                    style: ButtonStyle(
                      alignment: Alignment.center,
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(5),
                        ),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        int userId = int.parse(idController.text);

                        print("Deleting User ID: $userId");

                        // 🔥 LATER:
                        context.read<UserManagementBloc>().add(
                          DeleteUserEvent(userId),
                        );
                      }
                    },
                    child: state is DeleteUserLoading
                        ? SizedBox(
                            height: 18,
                            width: 18,

                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : Text(
                            "Delete User",
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
