import 'dart:developer';
import 'package:ai_chatbot/feature/chat/data/model/chat_model.dart';
import 'package:ai_chatbot/feature/chat/data/repository/firebase_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../data/repository/chat_repository.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  HomeRepository repository;
  FirebaseRepository firebaseRepository;
  ChatBloc({required this.repository, required this.firebaseRepository})
      : super(ChatInitial()) {
    on<ChatRequest>(_onMassageRequest);
    on<ChatHistory>(_onSetHistoryRequest);
    on<GetTodayChat>(_onGetTodayChat);
    on<NewChatEvent>(_onNewChatEvent);
  }

  _onNewChatEvent(NewChatEvent event, Emitter<ChatState> emit) {
    emit(ChatLoaded(
        isNewChat: true,
        data: ChatModel(
            date: DateFormat('yyyy-MM-dd').format(DateTime.now()),
            candidates: [Candidates(content: Content(parts: []))])));
  }

  Future<void> _onGetTodayChat(
      GetTodayChat event, Emitter<ChatState> emit) async {
    try {
      final res = await firebaseRepository.getTodayChat();

      emit(ChatLoaded(data: res));
    } catch (e) {
      log("Error: $e");
      // emit(ChatError(message: "Failed to load chat data"));
    }
  }

  _onSetHistoryRequest(ChatHistory event, Emitter<ChatState> emit) async {
    emit(ChatLoaded(data: event.model));
  }

  _onMassageRequest(ChatRequest event, Emitter<ChatState> emit) async {
    Map<String, dynamic> body = {
      "contents": [
        {
          "parts": [
            {"text": event.msg}
          ]
        }
      ]
    };
    final CurrentState = state;
    if (CurrentState is ChatLoaded) {
      ChatModel updatedModel =
          CurrentState.data.copyWith(date: event.date, candidates: [
        CurrentState.data.candidates![0].copyWith(
            content: CurrentState.data.candidates![0].content!.copyWith(parts: [
          ...?CurrentState.data.candidates![0].content!.parts,
          ...[Parts(isUser: true, text: event.msg)],
        ]))
      ]);
      log("date1 ${updatedModel.date}");
      emit(ChatLoaded(isNewChat: event.isNewChat, data: updatedModel));
    } else if (CurrentState is ChatInitial) {
      ChatModel model = ChatModel(date: event.date, candidates: [
        Candidates(
            content: Content(parts: [Parts(isUser: true, text: event.msg)]))
      ]);
      emit(ChatLoaded(isNewChat: event.isNewChat, data: model));
    }
    final CurrentState1 = state;
    try {
      ChatModel response = await repository.getInformation(
          'AIzaSyDaKc-H4hWesxWJt6ARDVz7rYcBn0ILUQw', body);
      if (CurrentState1 is ChatLoaded) {
        ChatModel updatedModel =
            CurrentState1.data.copyWith(date: event.date, candidates: [
          CurrentState1.data.candidates![0].copyWith(
              content:
                  CurrentState1.data.candidates![0].content!.copyWith(parts: [
            ...?CurrentState1.data.candidates![0].content!.parts,
            ...response.candidates![0].content!.parts!,
          ]))
        ]);
        // Store updatedModel in Firebase before emitting the state
        firebaseRepository.appendPartsToFirestore(
            updatedModel, event.date, event.isNewChat);

        log("date ${updatedModel.date}");
        emit(ChatLoaded(
          isNewChat: event.isNewChat,
          data: updatedModel,
        ));
      } else {
        emit(ChatLoaded(data: response));
      }
    } catch (e) {
      emit(ChatException(errorMessage: e.toString()));
    }
  }
}
