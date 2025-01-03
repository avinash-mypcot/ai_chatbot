import '../../../chat/data/model/chat_model.dart';
import '../services/firebase_service.dart';

class FirebaseRepository {
  final FirebaseServices _services;
  const FirebaseRepository({required FirebaseServices service})
      : _services = service,
        super();

  Future<ChatModel> getTodayChat() async {
    try {
      final response = await _services.getTodayChat();
      return response;
    } catch (e) {
      rethrow;
    }
  }

   Future<void> appendPartsToFirestore(ChatModel updatedModel,String date,bool isNewChat) async {
    try {
      final response = await _services.appendPartsToFirestore(updatedModel, date,isNewChat);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
