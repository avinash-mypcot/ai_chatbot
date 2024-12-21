import 'package:ai_chatbot/feature/chat/data/model/chat_model.dart';
import 'package:dio/dio.dart';

import '../api/chat_api.dart';

class ChatServices {
  final ChatApi _api;
  final Dio _dio;
  ChatServices({required ChatApi api,required Dio dio}):_api=api,_dio=dio,super();
   Future<ChatModel> getInformation() async {
    try {
      return _api.getInformation();
    } catch (e) {
      rethrow;
    }
  }
}