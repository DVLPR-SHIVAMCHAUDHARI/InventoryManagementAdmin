import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_management_admin_pannel/core/Utils/asset_url.dart';
import 'package:inventory_management_admin_pannel/core/Utils/globals.dart';
import 'package:inventory_management_admin_pannel/core/Utils/snack_bar.dart';
import 'package:inventory_management_admin_pannel/features/Authentication/bloc/auth_bloc.dart';
import 'package:inventory_management_admin_pannel/features/Authentication/bloc/auth_event.dart';
import 'package:inventory_management_admin_pannel/features/Authentication/bloc/auth_state.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController emailField = TextEditingController();
  TextEditingController passField = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 420,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 15,
                  offset: Offset(0, 6),
                ),
              ],
            ),
            child: Form(
              key: formkey,
              child: BlocListener<AuthBloc, AuthState>(
                listener: (context, state) async {
                  if (state is SignInSuccessState) {
                    await snackbar(
                      context,
                      color: Colors.green,
                      message: "Sign In Success",
                      title: "Great",
                      type: ContentType.success,
                    );
                    router.goNamed(Routes.dashboard.name);
                  } else if (state is SignInFailureState) {
                    snackbar(
                      context,
                      color: Colors.red,
                      type: ContentType.failure,
                      title: "Oops",
                      message: state.message,
                    );
                  }
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    /// Color bar on top
                    Container(
                      height: 18,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 36,
                      ),
                      child: Column(
                        children: [
                          Text(
                            "Inventory Management Admin",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                              color: Colors.blueGrey[900],
                            ),
                          ),

                          SizedBox(height: 10),

                          Text(
                            "Log In",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.blue,
                            ),
                          ),

                          SizedBox(height: 28),

                          /// Email
                          _label("Email Address / User"),
                          SizedBox(height: 6),

                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "This field is required";
                              }
                              return null;
                            },
                            controller: emailField,
                            decoration: InputDecoration(
                              hintText: "email address / user",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 14,
                              ),
                            ),
                          ),

                          SizedBox(height: 20),

                          /// Password
                          _label("Password"),
                          SizedBox(height: 6),

                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "This field is required";
                              }
                              return null;
                            },
                            onFieldSubmitted: (value) {
                              if (formkey.currentState!.validate()) {
                                context.read<AuthBloc>().add(
                                  SignInEvent(emailField.text, passField.text),
                                );
                              }
                            },
                            controller: passField,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: "Password",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 14,
                              ),
                            ),
                          ),

                          SizedBox(height: 30),

                          /// Submit
                          BlocBuilder<AuthBloc, AuthState>(
                            builder: (context, state) {
                              return loginbutton(
                                formkey: formkey,
                                state: state,
                                context: context,
                                emailController: emailField,
                                passwordController: passField,
                              );
                            },
                          ),

                          SizedBox(height: 28),
                          const Divider(),
                          SizedBox(height: 12),

                          _footer(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Reusable label
Widget _label(String text) {
  return Align(
    alignment: Alignment.centerLeft,
    child: Text(
      text,

      style: TextStyle(
        fontSize: 14,
        color: Colors.grey[700],
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}

/// Footer Widget
Widget _footer() {
  return Column(
    children: [
      SizedBox(height: 50, child: Image.asset(AssetUrl.icUnimeshTechnology)),
      SizedBox(height: 4),
      Text(
        "Connecting Future!",
        style: TextStyle(
          fontStyle: FontStyle.italic,
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.purple,
        ),
      ),
    ],
  );
}

loginbutton({
  required GlobalKey<FormState> formkey,
  required AuthState state,
  required BuildContext context,
  required TextEditingController emailController,
  required TextEditingController passwordController,
}) {
  return SizedBox(
    width: double.infinity,
    child: FilledButton(
      style: FilledButton.styleFrom(
        backgroundColor: Colors.blue,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
      onPressed: state is SignInLoadingState
          ? null
          : () {
              if (formkey.currentState!.validate()) {
                context.read<AuthBloc>().add(
                  SignInEvent(
                    emailController.text.trim(),
                    passwordController.text.trim(),
                  ),
                );
              }
            },
      child: state is SignInLoadingState
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              ),
            )
          : const Text(
              "Submit",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.white,
              ),
            ),
    ),
  );
}
