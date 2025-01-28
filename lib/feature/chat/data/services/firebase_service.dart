import 'package:ai_chatbot/feature/chat/data/model/chat_model.dart';

import '../api/firebase_chat_api.dart';
import '../api/supabase_chat_api.dart';

class FirebaseServices {
  // final FirebaseChatApi _api;
  final SupabaseChatApi _api;
  const FirebaseServices({required SupabaseChatApi api})
      : _api = api,
        super();
  Future<ChatModel> getTodayChat() async {
    try {
      var res = await _api.getTodayChat();
      return res;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> appendPartsToFirestore(
      ChatModel updatedModel, String date, bool isNewChat,int index) async {
    try {
      var res = await _api.appendPartsToSupabase(updatedModel, date,index,isNewChat:isNewChat);
      return res;
    } catch (e) {
      rethrow;
    }
  }
}
