import 'package:ai_chatbot/feature/chat/data/model/chat_model.dart';

import '../services/chat_services.dart';

class HomeRepository {
  final ChatServices _services;
  HomeRepository({required ChatServices service})
      : _services = service,
        super();

  Future<ChatModel> getInformation() async {
    try {
      return _services.getInformation();
    } catch (e) {
      rethrow;
    }
  }
}
