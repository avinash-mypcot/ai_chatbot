import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/textstyles.dart';
import '../bloc/chat_bloc.dart';

class BottomBoxWidget extends StatefulWidget {
  const BottomBoxWidget({super.key, required this.scroll, required this.msg});
  final VoidCallback scroll;
  final TextEditingController msg;

  @override
  State<BottomBoxWidget> createState() => _BottomBoxWidgetState();
}

class _BottomBoxWidgetState extends State<BottomBoxWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            flex: 100,
            child: Stack(
              children: [
                TextFormField(
                  textAlignVertical: TextAlignVertical.top,
                  cursorColor: AppColors.kColorWhite,
                  style: kTextStylePoppins300.copyWith(
                    color: AppColors.kColorWhite,
                  ),
                  controller: widget.msg,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding:
                        EdgeInsets.only(left: 20.w, bottom: 15.h, top: 15.h),
                    disabledBorder: InputBorder.none,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.kColorWhite),
                      borderRadius: BorderRadius.circular(200.r),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColors.kColorWhite, width: 2.0),
                      borderRadius: BorderRadius.circular(200.r),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColors.kColorWhite, width: 1.0),
                      borderRadius: BorderRadius.circular(200.r),
                    ),
                    label: Text(
                      'Enter Your Message',
                      style: kTextStylePoppins300.copyWith(
                          height: 1, color: AppColors.kColorWhite),
                    ),
                  ),
                ),
                Positioned(
                  right: 2,
                  bottom: 8.6,
                  child: GestureDetector(
                    onTap: () {
                      context
                          .read<ChatBloc>()
                          .add(ChatRequest(msg: widget.msg.text.trim()));
                      widget.msg.clear();
                      widget
                          .scroll; // Scroll to the end when a new message is sent
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 8.w, top: 6.h),
                      height: 35.h,
                      width: 35.h,
                      decoration: BoxDecoration(
                        color: AppColors.kColorBlack,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.send,
                          color: AppColors.kColorWhite,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
