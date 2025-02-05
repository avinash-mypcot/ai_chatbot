import 'dart:developer';

import 'package:ai_chatbot/feature/chat/data/model/chat_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../chat/data/services/encription_helper.dart';
import '../model/history_model.dart';

class HistoryApi {
  const HistoryApi();
 
  Future<HistoryModel> getHistory() async {
    final uId = Supabase.instance.client.auth.currentUser!.id;
  final SupabaseClient supabase = Supabase.instance.client;

    final encryptionHelper =
        EncryptionHelper('6gHdJ1kLmNoP8b2x', '3xTu9R4dWq8YtZkC');

    try {
      // Fetch data from Firestore under the given uId
      // final snapshot = await FirebaseFirestore.instance
      //     .collection('chatModels') // Root Firestore collection
      //     .doc(uId) // Document for the specific user
      //     .collection('chats') // Sub-collection for chats
      //     .orderBy('date', descending: true) // Sort by date
      //     .get();

      final response = await supabase.from('chat_models').select().eq('user_id', uId);

      log("${response[0]['chats'].runtimeType}");

      // Map Firestore data to HistoryModel
      final List<Data> fetchedData = response.map((doc) {
        var data = doc;
        log('DATA : $data');

        // Initialize chats as an empty list
        List<ChatModel> chats = [];

        if (data['chats'] is List<dynamic>) {
          log("IN LIST LIST LIST LIST ");
          // Handle case when data['chats'] is a list
          chats = (data['chats'] as List<dynamic>).map((chat) {
            final contentJson;
            if (chat['candidates'].runtimeType == List<dynamic>) {
              contentJson = chat['candidates'][0]['content'];
            } else {
              contentJson = chat['candidates']['0']['content'];
            }
            final content = Content.fromJson(contentJson);

            // Extract partss
            final List<Parts> parts = content.parts ?? [];
            // log("${ DateFormat('yyyy-MM-dd').format(DateTime.parse(response[0]['date']))}");
            // final dateTime = (response[0]['date'] as Timestamp).toDate();
            // final formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
              final formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.parse(data['date']));
            final model = ChatModel(
              date: formattedDate,
              candidates: [
                Candidates(content: Content(parts: parts), date: formattedDate),
              ],
            );
            ChatModel dencryptedModel = model.copyWith(candidates: [
              model.candidates![0].copyWith(
                  content: model.candidates![0].content!.copyWith(parts: [
                for (var part in model.candidates![0].content!.parts!)
                  Parts(
                    base64Image: part.base64Image,
                    isUser: part.isUser,
                    text: encryptionHelper.decryptText(part.text!),
                  )
              ]))
            ]);

            log("MODEL : ${dencryptedModel.date}");

            return dencryptedModel;
          }).toList();
        } else if (data['chats'] is Map<String, dynamic>) {
          // Handle case when data['chats'] is a map
          final mapChats = data['chats'] as Map<String, dynamic>;
          for (int i = 0; i < mapChats.length; i++) {}
          chats = mapChats.entries.map((entry) {
            final chat = entry.value;
            final contentJson;
            if (chat['candidates'].runtimeType == List<dynamic>) {
              contentJson = chat['candidates'][0]['content'];
            } else {
              contentJson = chat['candidates']['0']['content'];
            }

            // log("DATA 1: ${contentJson['parts']}");
            final content = Content.fromJson(contentJson);

            // Extract parts
            final List<Parts> parts = content.parts ?? [];
            final dateTime = (response[0]['date'] as Timestamp).toDate();
            final formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);

            final model = ChatModel(
              date: formattedDate,
              candidates: [
                Candidates(content: Content(parts: parts), date: formattedDate),
              ],
            );
            log("DATA : ${model.date}");
            ChatModel dencryptedModel = model.copyWith(candidates: [
              model.candidates![0].copyWith(
                  content: model.candidates![0].content!.copyWith(parts: [
                for (var part in model.candidates![0].content!.parts!)
                  Parts(
                    time: part.time,
                    base64Image: part.base64Image,
                    isUser: part.isUser,
                    text: encryptionHelper.decryptText(part.text!),
                  )
              ]))
            ]);

            return dencryptedModel;
          }).toList();
        }

        // Create Date object
        final Date dateObject = Date(chats: chats);

        // Create Data object
        return Data(date: dateObject);
      }).toList();

      // Return the mapped HistoryModel
      return HistoryModel(data: fetchedData);
    } catch (e) {
      print("Error fetching chat history for uId $uId: $e");
      rethrow;
    }
  }
}
