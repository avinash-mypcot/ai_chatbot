import 'dart:developer';

import 'package:ai_chatbot/feature/chat/data/model/chat_model.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import '../../data/repository/chat_repository.dart';
import '../../data/services/firebase_service.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  HomeRepository repository;
  ChatBloc({required this.repository}) : super(ChatInitial()) {
    on<ChatRequest>(_onMassageRequest);
    on<ChatHistory>(_onSetHistoryRequest);
    on<GetTodayChat>(_onGetTodayChat);
  }

  Future<void> _onGetTodayChat(
      GetTodayChat event, Emitter<ChatState> emit) async {
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      final uId = auth.currentUser?.uid;

      final todayDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
      log("DAte : $todayDate");
      final snapshot = await FirebaseFirestore.instance
          .collection('chatModels')
          .doc(uId)
          .collection('chats')
          .doc(todayDate)
          .get();
      log("Data Length:  ${snapshot.data()}");

      final data = snapshot.data();
      if (data == null) {
        emit(ChatLoaded(
            data: ChatModel(
                date: todayDate,
                candidates: [Candidates(content: Content(parts: []))])));
        return;
      }

      // Safely navigate the structure and deserialize the data
      final chats = data!['chats'];
      log("Data ${chats!['0']}");

      final candidates = chats['0']['candidates'];

      final contentJson = candidates['0']['content'] as Map<String, dynamic>?;

      final content = Content.fromJson(contentJson!);

      // Parse parts and date
      List<Parts> parts = content.parts!;
      final timestamp = data['date'] as Timestamp?;
      final formattedDate = timestamp != null
          ? DateFormat('yyyy-MM-dd HH:mm:ss').format(timestamp.toDate())
          : "Unknown Date";

      final model = ChatModel(
        date: todayDate,
        candidates: [
          Candidates(content: content, date: formattedDate),
        ],
      );

      emit(ChatLoaded(data: model));
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
      emit(ChatLoaded(data: updatedModel));
    } else if (CurrentState is ChatInitial) {
      ChatModel model = ChatModel(date: event.date, candidates: [
        Candidates(
            content: Content(parts: [Parts(isUser: true, text: event.msg)]))
      ]);
      emit(ChatLoaded(data: model));
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
        await appendPartsToFirestore(updatedModel, event.date);
        log("date ${updatedModel.date}");
        emit(ChatLoaded(
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
