import 'package:ai_chatbot/feature/chat/data/model/chat_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/config/app_config.dart';

@RestApi(baseUrl: AppConfig.baseUrl)
abstract class ChatApi {
  factory ChatApi({Dio dio}) = _ChatApi;

  @POST(AppConfig.chatApi)
  Future<ChatModel> getInformation({@Query('key') String key });
}
