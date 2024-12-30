import 'package:ai_chatbot/core/theme/app_colors.dart';
import 'package:ai_chatbot/core/theme/textstyles.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../bloc/signup_bloc.dart';
import '../bloc/signup_event.dart';
import '../bloc/signup_state.dart';
import '../widgets/signup_textfield.dart';

@RoutePage()
class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onSignUp() {
    if (_formKey.currentState!.validate()) {
      // Trigger the signup event with Bloc or any other backend logic
      context.read<SignUpBloc>().add(SignUpSubmittedEvent(
            username: _usernameController.text,
            email: _emailController.text,
            password: _passwordController.text,
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sign Up',
          style: kTextStylePoppins400.copyWith(
              fontSize: 16.sp, color: AppColors.kColorWhite),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Container(
        height: double.infinity,
        color: AppColors.kColorBlack.withValues(alpha: 0.85),
        child: Padding(
          padding: EdgeInsets.all(16.0.sp),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Create an Account",
                    style: kTextStylePoppins500.copyWith(
                        fontSize: 24.sp, color: AppColors.kColorGrey),
                  ),
                  SizedBox(height: 24.h),
                  // Username Field
                  Text(
                    "Name",
                    style: kTextStylePoppins300.copyWith(
                        color: AppColors.kColorGrey),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  SignupTextfield(
                    nameController: _usernameController,
                    textHint: 'User Name',
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your username';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.h),
                  // Email Field
                  Text(
                    "Email",
                    style: kTextStylePoppins300.copyWith(
                        color: AppColors.kColorGrey),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  SignupTextfield(
                    nameController: _emailController,
                    textHint: 'Enter Email',
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                          .hasMatch(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.h),
                  // Password Field
                  Text(
                    "Password",
                    style: kTextStylePoppins300.copyWith(
                        color: AppColors.kColorGrey),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  SignupTextfield(
                    nameController: _emailController,
                    textHint: 'Enter Password',
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters long';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 24.h),
                  // Sign Up Button
                  BlocBuilder<SignUpBloc, SignUpState>(
                    builder: (context, state) {
                      if (state is SignUpLoadingState) {
                        return Center(child: CircularProgressIndicator());
                      }
                      return SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _onSignUp,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.kColorGrey,
                          ),
                          child: Text(
                            "Sign Up",
                            style: kTextStylePoppins400.copyWith(
                                fontSize: 16.sp, color: AppColors.kColorBlack),
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account? Login",
                        style: kTextStylePoppins300.copyWith(
                            color: AppColors.kColorGrey),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
