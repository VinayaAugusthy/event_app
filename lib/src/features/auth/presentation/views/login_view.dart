import 'package:event_app/src/common/widgets/button_widget.dart';
import 'package:event_app/src/common/widgets/textformfield_widget.dart';
import 'package:event_app/src/core/constants/colors.dart';
import 'package:event_app/src/core/constants/string_constants.dart';
import 'package:event_app/src/core/extensions/mediaquery_extension.dart';
import 'package:event_app/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:event_app/src/features/auth/presentation/views/signup_view.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final loginFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
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
                key: loginFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      AppStrings.login,
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
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        return SizedBox(
                          width: context.screenWidth,
                          child: ElevatedButtonWidget(
                            buttonText: AppStrings.login,
                            onPressed: () {
                              if (loginFormKey.currentState?.validate() ??
                                  false) {
                                BlocProvider.of<AuthBloc>(context).add(
                                  SignInUser(
                                    emailController.text.trim(),
                                    passwordController.text.trim(),
                                    context,
                                  ),
                                );
                              }
                            },
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 30),
                    RichText(
                      text: TextSpan(
                        text: AppStrings.dontHaveAccount,
                        style: TextStyle(color: AppColors.black),
                        children: [
                          TextSpan(
                            text: AppStrings.signUp,
                            style: TextStyle(
                              color: AppColors.red,
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer:
                                TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SignupView(),
                                      ),
                                    );
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
