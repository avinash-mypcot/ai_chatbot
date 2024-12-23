import 'package:ai_chatbot/core/theme/app_colors.dart';
import 'package:ai_chatbot/core/theme/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessageWidget extends StatefulWidget {
  final bool isUser;
  final String message;
  final String date;

  const MessageWidget(
      {super.key,
      required this.isUser,
      required this.message,
      required this.date});

  @override
  _MessageWidgetState createState() => _MessageWidgetState();
}

class _MessageWidgetState extends State<MessageWidget> {
  bool _isExpanded = false; // Track if the message is expanded

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.symmetric(vertical: 15).copyWith(
          left: widget.isUser ? 100 : 10, right: widget.isUser ? 10 : 100),
      decoration: BoxDecoration(
          color: widget.isUser ? AppColors.kColorblue : AppColors.kColorGrey,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              bottomLeft: widget.isUser ? Radius.circular(10) : Radius.zero,
              topRight: Radius.circular(10),
              bottomRight: widget.isUser ? Radius.zero : Radius.circular(10))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.isUser
                ? widget.message
                : _isExpanded
                    ? widget.message
                    : (widget.message.length > 100
                        ? '${widget.message.substring(0, 100)}...'
                        : widget.message),
            style: kTextStylePoppins200.copyWith(
                fontSize: 14.sp,
                color: widget.isUser
                    ? AppColors.kColorWhite
                    : AppColors.kColorBlack),
          ),
          if (widget.message.length > 100)
            GestureDetector(
              onTap: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
              child: Text(
                _isExpanded ? 'See less' : 'See more',
                style: kTextStylePoppins200.copyWith(
                  textBaseline: TextBaseline.alphabetic,
                  fontSize: 12.sp,
                  color:
                      AppColors.kColorblue, // Customize your "See more" color
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          Text(
            widget.date,
            style: TextStyle(
              fontSize: 10,
              color:
                  widget.isUser ? AppColors.kColorWhite : AppColors.kColorBlack,
            ),
          ),
        ],
      ),
    );
  }
}
