import 'package:ai_chatbot/core/theme/app_colors.dart';
import 'package:ai_chatbot/feature/chat/presentation/bloc/chat_bloc.dart';
import 'package:ai_chatbot/feature/chat/presentation/widgets/massege_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../widgets/bottom_box_widget.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class Message {
  final bool isUser;
  final String message;
  final DateTime date;

  Message({required this.isUser, required this.message, required this.date});
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _userInput = TextEditingController();
  final ScrollController _scrollController =
      ScrollController(); // Add ScrollController

  @override
  void dispose() {
    _userInput.dispose();
    _scrollController.dispose(); // Dispose of the controller
    super.dispose();
  }

  void _scrollToEnd() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.kColorGrey,
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                colorFilter: ColorFilter.mode(
                  AppColors.kColorBlack.withOpacity(0.8),
                  BlendMode.dstATop,
                ),
                image: AssetImage('assets/images/back_img.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: BlocBuilder<ChatBloc, ChatState>(
                    builder: (context, state) {
                      if (state is ChatLoaded) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          // _scrollToEnd(); // Scroll to the end when new messages are loaded
                        });
                        _scrollToEnd();
                        return ListView.builder(
                          controller:
                              _scrollController, // Attach the controller
                          itemCount:
                              state.data.candidates![0].content!.parts!.length,
                          itemBuilder: (context, index) {
                            final message = state.data.candidates![0].content!
                                .parts![index].text;

                            return MessageWidget(
                              isUser: state.data.candidates![0].content!
                                      .parts![index].isUser ??
                                  false,
                              message: message!,
                              date: DateFormat('HH:mm').format(DateTime.now()),
                            );
                          },
                        );
                      }
                      return SizedBox();
                    },
                  ),
                ),
                BottomBoxWidget(
                  scroll: _scrollToEnd,
                  msg: _userInput,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
