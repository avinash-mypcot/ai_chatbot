import 'package:ai_chatbot/core/router/app_router.gr.dart';
import 'package:ai_chatbot/feature/auth/signup/presentation/bloc/signup_bloc.dart';
import 'package:ai_chatbot/feature/auth/signup/presentation/bloc/signup_state.dart';
import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:ai_chatbot/core/theme/app_colors.dart';
import 'package:ai_chatbot/core/theme/textstyles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../bloc/signup_event.dart';
import '../widgets/signup_textfield.dart';

@RoutePage()
class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
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
                          "Register",
                          style: kTextStylePoppins500.copyWith(
                              fontSize: 24.sp, color: AppColors.kColorGrey),
                        ),
                        SizedBox(height: 30.h),
                        // Phone Number Field
                        if (!isOtpSent) ...[
                          Text(
                            "Email Address",
                            style: kTextStylePoppins300.copyWith(
                                color: AppColors.kColorGrey),
                          ),
                          SizedBox(height: 8.h),
                          SignupTextfield(
                            nameController: _emailController,
                            textHint: 'Enter Email',
                            validation: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your Email';
                              }
                              // if (!RegExp(r'^\+?[0-9]{10,15}$').hasMatch(value)) {
                              //   return 'Please enter a valid Email';
                              // }
                              return null;
                            },
                          ),
                        ],
                        // OTP Field
                        SizedBox(
                          height: 30.h,
                        ),
                        Text(
                          "Password",
                          style: kTextStylePoppins300.copyWith(
                              color: AppColors.kColorGrey),
                        ),
                        SizedBox(height: 8.h),
                        SignupTextfield(
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
                              context.read<SignUpBloc>().add(SignupReqEvent(
                                  email: _emailController.text,
                                  password: _passController.text));
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.all(12.sp),
                            decoration: BoxDecoration(
                                color: AppColors.kColorGrey,
                                borderRadius: BorderRadius.circular(12.r)),
                            child: Center(
                              child: Text(
                                "Register",
                                style: kTextStylePoppins600.copyWith(
                                    color: AppColors.kColorBlack),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account ?",
                              style: kTextStylePoppins300.copyWith(
                                  color: AppColors.kColorGrey),
                            ),
                            GestureDetector(
                              onTap: () {
                                context.router.replace(SignInRoute());
                              },
                              child: Text(
                                " Login",
                                style: kTextStylePoppins300.copyWith(
                                    color: AppColors.kColorGrey),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          BlocConsumer<SignUpBloc, SignUpState>(builder: (context, state) {
            if (state is SignUpLoadingState) {
              return Center(
                  child: SizedBox(child: CircularProgressIndicator()));
            }
            return SizedBox();
          }, listener: (context, state) {
            if (state is SignUpException) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("${state.errorMessage}")));
            } else if (state is SignUpSuccessState) {
              context.router.replace(SignInRoute());
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("${state.model.message}")));
            }
          })
        ],
      ),
    );
  }
}
