import 'package:ai_chatbot/feature/chat/data/model/chat_model.dart';
import 'package:dio/dio.dart';

import '../api/history_api.dart';

class HistoryServices {
  final HistoryApi _api;
  const HistoryServices({required HistoryApi api,required Dio dio}):_api =api,super();
  Future<List<ChatModel>> getHistory() async{
    try{
      var res = await _api.getHistory();
      return res;
    }catch(e){
      rethrow;
    }
  }
}