import 'package:event_app/src/common/widgets/button_widget.dart';
import 'package:event_app/src/common/widgets/textformfield_widget.dart';
import 'package:event_app/src/core/constants/colors.dart';
import 'package:event_app/src/core/constants/string_constants.dart';
import 'package:event_app/src/core/extensions/mediaquery_extension.dart';
import 'package:event_app/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final signUpFormKey = GlobalKey<FormState>();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(context.screenWidth / 16),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: signUpFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      AppStrings.signUp,
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: AppColors.red,
                      ),
                    ),
                    SizedBox(height: context.screenHeight / 18),
                    TextFormFieldWidget(
                      controller: emailController,
                      hintText: AppStrings.enterEmail,
                      errorMsg: AppStrings.emailRequired,
                    ),
                    SizedBox(height: 30),
                    TextFormFieldWidget(
                      controller: passwordController,
                      hintText: AppStrings.enterPassword,
                      errorMsg: AppStrings.passwordRequired,
                      isObscure: true,
                    ),
                    SizedBox(height: 30),
                    TextFormField(
                      controller: confirmPasswordController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        hintText: AppStrings.confirmPassword,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppStrings.confirmPasswordRequired;
                        } else if (value.trim() !=
                            passwordController.text.trim()) {
                          return AppStrings.passwordsNotMatching;
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 30),
                    SizedBox(
                      width: context.screenWidth,
                      child: ElevatedButtonWidget(
                        onPressed: () {
                          if (signUpFormKey.currentState?.validate() ?? false) {
                            BlocProvider.of<AuthBloc>(context).add(
                              SignUpUser(
                                emailController.text.trim(),
                                passwordController.text.trim(),
                                context,
                              ),
                            );
                          }
                        },
                        buttonText: AppStrings.signUp,
                      ),
                    ),
                    SizedBox(height: 30),
                    RichText(
                      text: TextSpan(
                        text: AppStrings.alreadyHaveAccount,
                        style: TextStyle(color: AppColors.black),
                        children: [
                          TextSpan(
                            text: AppStrings.login,
                            style: TextStyle(
                              color: AppColors.red,
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer:
                                TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pop(context);
                                  },
                          ),
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
