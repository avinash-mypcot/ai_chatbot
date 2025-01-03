import 'package:ai_chatbot/feature/chat/data/model/chat_model.dart';

import '../api/firebase_chat_api.dart';

class FirebaseServices {
  final FirebaseChatApi _api;
  const FirebaseServices({required FirebaseChatApi api})
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
      ChatModel updatedModel, String date, bool isNewChat) async {
    try {
      var res = await _api.appendPartsToFirestore(updatedModel, date,isNewChat:isNewChat);
      return res;
    } catch (e) {
      rethrow;
    }
  }
}
