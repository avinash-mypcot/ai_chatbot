import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/textstyles.dart';

@RoutePage()
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            context.router.popForced();
          },
          child: Icon(Icons.arrow_back),
        ),
        foregroundColor: AppColors.kColorWhite,
        scrolledUnderElevation: 0,
        centerTitle: true,
        backgroundColor: AppColors.kColorBlack.withValues(alpha: 0.9),
        title: Text(
          "Profile",
          style: kTextStylePoppins400.copyWith(
              fontSize: 16.sp, color: AppColors.kColorWhite),
        ),
      ),
      body: Container(
        color: AppColors.kColorBlack.withValues(alpha: 0.85),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Profile Picture
                  CircleAvatar(
                    radius: 30.r,
                    backgroundImage: AssetImage(
                        'assets/profile_placeholder.png'), // Replace with your image asset
                    child: Icon(Icons.person, size: 50, color: Colors.white),
                  ),
                  SizedBox(height: 10.h),

                  // User Name
                  Text(
                    'John Doe',
                    style: kTextStylePoppins400.copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.kColorWhite),
                  ),

                  // User Email
                  Text(
                    'johndoe@example.com',
                    style: kTextStylePoppins400.copyWith(
                        fontSize: 12.sp, color: AppColors.kColorWhite),
                  ),
                  SizedBox(height: 24),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
