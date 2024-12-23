part of 'chat_bloc.dart';

sealed class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class ChatRequest extends ChatEvent {
  const ChatRequest({required this.msg});
  final String msg;

  @override
  List<Object> get props => [];
}
