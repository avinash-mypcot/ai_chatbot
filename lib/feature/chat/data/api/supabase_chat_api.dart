import 'dart:developer';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/intl.dart';
import '../model/chat_model.dart';
import '../services/encription_helper.dart';

class SupabaseChatApi {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<ChatModel> getTodayChat() async {
    final encryptionHelper = EncryptionHelper('6gHdJ1kLmNoP8b2x', '3xTu9R4dWq8YtZkC');
    try {
      final currentUser = await _supabase.auth.currentUser!;
      final uId = currentUser?.id;
      final todayDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

      // Query the chat for today
      final response = await _supabase
          .from('chat_models')
          .select()
          .eq('user_id', uId!)
          .eq('date', todayDate)
          .maybeSingle();

log("RESPONSE : ${response}");
      if ( response == null) {
        return ChatModel(
          date: todayDate,
          candidates: [Candidates(content: Content(parts: []))],
        );
      }
      log('message ${response['chats'][0]['candidates']}');
      final candidates = response['chats'][0]['candidates'];
      final contentJson = candidates[0]['content'] as Map<String, dynamic>?;
      final content = Content.fromJson(contentJson!);

      // Parse parts and date
      List<Parts> parts = content.parts!;

      final model = ChatModel(
        date: todayDate,
        candidates: [
          Candidates(content: content, date: todayDate),
        ],
      );

      // Decrypt message content
      final decryptedModel = model.copyWith(
        candidates: [
          model.candidates![0].copyWith(
            content: model.candidates![0].content!.copyWith(
              parts: [
                for (var part in model.candidates![0].content!.parts!)
                  Parts(
                    time: part.time,
                    base64Image: part.base64Image,
                    isUser: part.isUser,
                    text: encryptionHelper.decryptText(part.text!),
                  )
              ],
            ),
          ),
        ],
      );

      return decryptedModel;
    } catch (e) {
      log("ERROR : $e");
      rethrow;
    }
  }

  
   Future<void> appendPartsToSupabase(ChatModel chatModel, String documentId, int index, {bool isNewChat = false}) async {
    try {
      final currentUser = await _supabase.auth.currentUser;
      final uId = currentUser?.id;

      // Extract the parts to be appended
      List<dynamic> newParts = chatModel.candidates!
          .expand((candidate) => candidate.content?.parts ?? [])
          .map((part) => part.toJson())
          .toList();

      // Check if the chat already exists
      final response = await _supabase
          .from('chat_models')
          .select('chats')
          .eq('user_id', uId!)
          .eq('date', documentId)
          .maybeSingle();
          log("RESPONSE $response");

      if ( response == null) {
        // Create new chat entry if not found
        await _supabase.from('chat_models').insert({
          'user_id': uId,
          'date': documentId,
          'chats': [
            {
              'candidates': [
                {'content': {'parts': newParts}}
              ]
            }
          ],
        });
      } else {
        // Append new parts to existing chat
        if (isNewChat) {
          log("it is in New chat ");
          await _supabase.from('chat_models').update({
           
            'chats': [
              ...response['chats'],
              {'candidates': [{'content': {'parts': newParts}}]}
            ]
          }).eq('user_id', uId).eq('date', documentId);
        } else {
          final data = [...response['chats']];
          data[index]={
                'candidates': [{'content': {'parts': newParts}}],
              };
              log("DAtA : $data");
          await _supabase.from('chat_models').update({
            'chats': 
              data
             
          }).eq('user_id', uId).eq('date', documentId);
        }
      }

      print("Parts successfully appended to Supabase!");
    } catch (e) {
      print("Error appending parts to Supabase: $e");
    }
  }

}
