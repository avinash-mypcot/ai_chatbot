import 'package:ai_chatbot/core/router/app_router.gr.dart';
import 'package:ai_chatbot/core/theme/textstyles.dart';
import 'package:ai_chatbot/feature/profile/presentation/bloc/profile_bloc.dart';
import 'package:auto_route/auto_route.dart';
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
                                    context.router.push(ProfileRoute());
                                    context.router.maybePop();
                                    // context
                                    //     .read<ProfileBloc>()
                                    //     .add(ProfileGetEvent());
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
            }
          })
        ],
      ),
    );
  }
}
