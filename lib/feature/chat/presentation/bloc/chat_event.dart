part of 'chat_bloc.dart';

sealed class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class ChatRequest extends ChatEvent {
  const ChatRequest({required this.msg, required this.date});
  final String msg;
   final String date;

  @override
  List<Object> get props => [];
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
