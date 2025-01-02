import 'package:ai_chatbot/core/router/app_router.gr.dart';
import 'package:ai_chatbot/core/theme/textstyles.dart';
import 'package:ai_chatbot/feature/profile/presentation/bloc/profile_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      clipBehavior: Clip.none,
      width: 250.w,
      elevation: 10, // Remove elevation
      shadowColor: AppColors.kColorBlack, // Remove shadow
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10.r),
                    bottomRight: Radius.circular(10.r)),
                color: AppColors.kColorBlack.withValues(alpha: 0.85),
                border: Border(
                  right: BorderSide(
                    color: AppColors.kColorGrey.withValues(alpha: 0.4),
                  ),
                )),
            height: double.infinity,
            width: 250.w,
            child: SafeArea(
              child: Column(
                children: [
                  BlocBuilder<ProfileBloc, ProfileState>(
                    builder: (context, state) {
                      if (state is ProfileLoadedState) {
                        return Column(
                          children: [
                            Container(
                                height: 80.h,
                                width: 80.h,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    // context.router.push(ProfileRoute());
                                    // context.router.maybePop();
                                    context
                                        .read<ProfileBloc>()
                                        .add(ProfileGetEvent());
                                  },
                                  child: Center(
                                    child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(200.r),
                                      child: Image.network(
                                          height: 70.sp,
                                          'https://www.shutterstock.com/image-vector/vector-flat-illustration-grayscale-avatar-600nw-2264922221.jpg'),
                                    ),
                                  ),
                                )),
                            SizedBox(
                              height: 12.h,
                            ),
                            Text(
                              state.model.name,
                              style: kTextStylePoppins400.copyWith(
                                  fontSize: 14.sp,
                                  color: AppColors.kColorWhite),
                            ),
                            Text(
                              '+91 ${state.model.mobile}',
                              style: kTextStylePoppins400.copyWith(
                                  fontSize: 14.sp,
                                  color: AppColors.kColorWhite),
                            ),
                          ],
                        );
                      }
                      return Column(
                        children: [
                          Container(
                              height: 80.h,
                              width: 80.h,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  context
                                      .read<ProfileBloc>()
                                      .add(ProfileGetEvent());
                                },
                                child: Center(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(200.r),
                                    child: Image.network(
                                        height: 70.sp,
                                        'https://www.shutterstock.com/image-vector/vector-flat-illustration-grayscale-avatar-600nw-2264922221.jpg'),
                                  ),
                                ),
                              )),
                          SizedBox(
                            height: 12.h,
                          ),
                          Text(
                            'NAME',
                            style: kTextStylePoppins400.copyWith(
                                fontSize: 14.sp, color: AppColors.kColorWhite),
                          ),
                          Text(
                            '+91 123456789',
                            style: kTextStylePoppins400.copyWith(
                                fontSize: 14.sp, color: AppColors.kColorWhite),
                          ),
                        ],
                      );
                    },
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            if (context.mounted) {
                              context.router.push(HistoryRoute());
                            }
                            context.router.maybePop();
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 12.w),
                            height: 40.h,
                            decoration: BoxDecoration(
                                border: Border(
                                    top:
                                        BorderSide(color: AppColors.kColorGrey),
                                    bottom: BorderSide(
                                        color: AppColors.kColorGrey))),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 12.w,
                                ),
                                Center(
                                  child: Text(
                                    'History',
                                    style: kTextStylePoppins400.copyWith(
                                        fontSize: 14.sp,
                                        color: AppColors.kColorWhite),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return Dialog(
                                    elevation: 0,
                                    child: Container(
                                      padding: EdgeInsets.all(12.sp),
                                      decoration: BoxDecoration(
                                          color: AppColors.kColorBlack
                                              .withValues(alpha: 0.8),
                                          borderRadius:
                                              BorderRadius.circular(12.r)),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                              padding: EdgeInsets.all(12.r),
                                              decoration: BoxDecoration(
                                                color: AppColors.kColored
                                                    .withValues(alpha: 0.15),
                                                // borderRadius:
                                                //     BorderRadius.circular(12.r),
                                                shape: BoxShape.circle,
                                              ),
                                              child: Icon(
                                                Icons.logout_sharp,
                                                color: AppColors.kColored
                                                    .withValues(alpha: 0.7),
                                              )),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          Text(
                                            "Logout ?",
                                            style: kTextStylePoppins600
                                                .copyWith(
                                                    fontSize: 16.sp,
                                                    color: AppColors.kColorWhite
                                                        .withValues(
                                                            alpha: 0.9)),
                                          ),
                                          SizedBox(
                                            height: 20.h,
                                          ),
                                          Text(
                                            "Are you sure you want to logout ?",
                                            style: kTextStylePoppins400
                                                .copyWith(
                                                    fontSize: 12.sp,
                                                    color: AppColors.kColorWhite
                                                        .withValues(
                                                            alpha: 0.9)),
                                          ),
                                          SizedBox(
                                            height: 15.h,
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: GestureDetector(
                                                  onTap: () {
                                                    context.router.maybePop();
                                                  },
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.all(10.sp),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12.r),
                                                        border: Border.all(
                                                            color: AppColors
                                                                .kColored
                                                                .withValues(
                                                                    alpha:
                                                                        0.7))),
                                                    child: Center(
                                                      child: Text(
                                                        "cancel",
                                                        style: kTextStylePoppins500
                                                            .copyWith(
                                                                fontSize: 14.sp,
                                                                color: AppColors
                                                                    .kColorWhite
                                                                    .withValues(
                                                                        alpha:
                                                                            0.9)),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 20.w,
                                              ),
                                              Expanded(
                                                child: GestureDetector(
                                                  onTap: () {
                                                    FirebaseAuth.instance
                                                        .signOut();
                                                    context.router
                                                        .popAndPushAll(
                                                            [SignInRoute()]);
                                                  },
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.all(10.sp),
                                                    decoration: BoxDecoration(
                                                      color: AppColors.kColored
                                                          .withValues(
                                                              alpha: 0.7),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12.r),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        "logout",
                                                        style: kTextStylePoppins500
                                                            .copyWith(
                                                                color: AppColors
                                                                    .kColorWhite
                                                                    .withValues(
                                                                        alpha:
                                                                            0.9),
                                                                fontSize:
                                                                    14.sp),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                });
                            context.router.maybePop();
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 12.w),
                            height: 40.h,
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: AppColors.kColorGrey))),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 12.w,
                                ),
                                Center(
                                  child: Text(
                                    'Logout',
                                    style: kTextStylePoppins400.copyWith(
                                        fontSize: 14.sp,
                                        color: AppColors.kColorWhite),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          BlocConsumer<ProfileBloc, ProfileState>(builder: (context, state) {
            if (state is ProfileLoadingState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return SizedBox();
          }, listener: (context, state) {
            if (state is ProfileLoadedState) {
              context.router.push(ProfileRoute());
              context.router.maybePop();
            } else if (state is ProfileFailedState) {}
          })
        ],
      ),
    );
  }
}
