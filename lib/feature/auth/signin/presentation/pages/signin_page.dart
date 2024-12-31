import 'package:ai_chatbot/core/router/app_router.gr.dart';
import 'package:ai_chatbot/feature/auth/signin/presentation/bloc/signin_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:ai_chatbot/core/theme/app_colors.dart';
import 'package:ai_chatbot/core/theme/textstyles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../bloc/signin_event.dart';
import '../bloc/signin_state.dart';
import '../widgets/signin_textfield.dart';

@RoutePage()
class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  bool isOtpSent = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            color: AppColors.kColorBlack.withOpacity(0.85),
            child: Padding(
              padding: EdgeInsets.all(16.0.sp),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Login",
                          style: kTextStylePoppins500.copyWith(
                              fontSize: 24.sp, color: AppColors.kColorGrey),
                        ),
                        SizedBox(height: 30.h),
                        Text(
                          "Email Address",
                          style: kTextStylePoppins300.copyWith(
                              color: AppColors.kColorGrey),
                        ),
                        SizedBox(height: 8.h),
                        SigninTextfield(
                          nameController: _emailController,
                          textHint: 'Enter Email',
                          validation: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 30.h),
                        Text(
                          "Password",
                          style: kTextStylePoppins300.copyWith(
                              color: AppColors.kColorGrey),
                        ),
                        SizedBox(height: 8.h),
                        SigninTextfield(
                          nameController: _passController,
                          textHint: 'Enter Password',
                          validation: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the password';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 30.h),
                        GestureDetector(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<SigninBloc>().add(SigninReqEvent(
                                  email: _emailController.text,
                                  password: _passController.text));
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.all(12.sp),
                            decoration: BoxDecoration(
                              color: AppColors.kColorGrey,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Center(
                              child: Text(
                                "Login",
                                style: kTextStylePoppins600.copyWith(
                                    color: AppColors.kColorBlack),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 30.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Create an account?",
                              style: kTextStylePoppins300.copyWith(
                                  color: AppColors.kColorGrey),
                            ),
                            GestureDetector(
                              onTap: () {
                                context.router.replace(SignUpRoute());
                              },
                              child: Text(
                                " Register",
                                style: kTextStylePoppins300.copyWith(
                                    color: AppColors.kColorGrey),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          BlocConsumer<SigninBloc, SigninState>(
            builder: (context, state) {
              if (state is SigninLoadingState) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return SizedBox();
            },
            listener: (context, state) {
              if (state is SigninException) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("${state.errorMessage}")),
                );
              } else if (state is SigninSuccessState) {
                context.router.replace(ChatRoute());
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("${state.model.message}")),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
