import 'dart:developer';

import 'package:ai_chatbot/core/theme/app_colors.dart';
import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/theme/textstyles.dart';
import '../../../chat/data/model/chat_model.dart';

@RoutePage()
class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  // Define a list to store chat history
  List<ChatModel> chatHistory = [];

  @override
  void initState() {
    super.initState();
    // Fetch data when the page is initialized
    _fetchChatHistory();
  }

  Future<void> _fetchChatHistory() async {
    try {
      // Fetch data from Firestore
      final snapshot = await FirebaseFirestore.instance
          .collection('chatModels') // your Firestore collection name
          .orderBy('date', descending: true) // Assuming there's a date field
          .get();
      // Map Firestore data to ChatModel
      final fetchedChats = snapshot.docs.map((doc) {
        log('Content : ${doc.data()['chats']['0']['candidates']['0']['content']}');
        final content = Content.fromJson(
            doc.data()['chats']['0']['candidates']['0']['content']);
        List<Parts> parts = content.parts ?? [];
        return ChatModel(
            candidates: [Candidates(content: Content(parts: parts))]);
      }).toList();
      setState(() {
        chatHistory = fetchedChats;
      });
      log('${chatHistory.first.candidates!.length}');
    } catch (e) {
      print("Error fetching chat history: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kColorGrey.withValues(alpha: 0.2),
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
          "History",
          style: kTextStylePoppins400.copyWith(
              fontSize: 16.sp, color: AppColors.kColorWhite),
        ),
      ),
      body: chatHistory.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: chatHistory.length,
              itemBuilder: (context, index) {
                final chat = chatHistory[index];
                return ChatCard(chat: chat);
              },
            ),
    );
  }
}

class ChatCard extends StatelessWidget {
  final ChatModel chat;

  const ChatCard({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
      child: Padding(
        padding: EdgeInsets.all(8.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (chat.candidates != null)
              ...chat.candidates!.map((candidate) {
                return Padding(
                  padding: EdgeInsets.only(top: 8.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (candidate.content?.parts != null)
                        ...candidate.content!.parts!.map((part) {
                          return Text(
                            part.text ?? '',
                            style:
                                kTextStylePoppins400.copyWith(fontSize: 14.sp),
                          );
                        }).toList(),
                    ],
                  ),
                );
              }).toList(),
          ],
        ),
      ),
    );
  }
}
