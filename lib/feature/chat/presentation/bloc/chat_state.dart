part of 'chat_bloc.dart';

sealed class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

final class ChatInitial extends ChatState {
  @override
  List<Object> get props => [];
}

class ChatLoading extends ChatState {
  @override
  List<Object> get props => [];
}

class ChatLoaded extends ChatState {
  const ChatLoaded({required this.data});
  final ChatModel data;

  @override
  List<Object> get props => [data];
}

class ChatException extends ChatState {
  const ChatException({required this.errorMessage});
  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}
