part of 'chat_bloc.dart';

sealed class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class ChatRequest extends ChatEvent {
  const ChatRequest({required this.msg, required this.date,this.isNewChat=false});
  final String msg;
  final String date;
  final bool isNewChat;

  @override
  List<Object> get props => [msg,date,isNewChat];
}

class ChatHistory extends ChatEvent {
  const ChatHistory({required this.model});
  final ChatModel model;

  @override
  List<Object> get props => [model];
}

class GetTodayChat extends ChatEvent {
  const GetTodayChat();
  @override
  List<Object> get props => [];
}

class NewChatEvent extends ChatEvent {
  const NewChatEvent();

  @override
  List<Object> get props => [];
}
class ImageResponseReq extends ChatEvent {
  final String imagePath;
  final String imageUrl;
  final String msg;
  final String mimeType;
  final String date;
  final bool isNewChat;
  const ImageResponseReq({required this.imagePath,required this.imageUrl, required this.msg,required this.mimeType,required this.date,required this.isNewChat});

  @override
  List<Object> get props => [imageUrl, msg,mimeType,imagePath,date,isNewChat];
}
