import 'package:ai_chatbot/feature/chat/data/model/chat_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/repository/chat_repository.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  HomeRepository repository;
  ChatBloc({required this.repository}) : super(ChatInitial()) {
    on<ChatRequest>(_onMassageRequest);
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
      ChatModel updatedModel = CurrentState.data.copyWith(candidates: [
        CurrentState.data.candidates![0].copyWith(
            content: CurrentState.data.candidates![0].content!.copyWith(parts: [
          ...?CurrentState.data.candidates![0].content!.parts,
          ...[Parts(isUser: true, text: event.msg)],
        ]))
      ]);
      emit(ChatLoaded(data: updatedModel));
    } else if (CurrentState is ChatInitial) {
      ChatModel model = ChatModel(candidates: [
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
        ChatModel updatedModel = CurrentState1.data.copyWith(candidates: [
          CurrentState1.data.candidates![0].copyWith(
              content:
                  CurrentState1.data.candidates![0].content!.copyWith(parts: [
            ...?CurrentState1.data.candidates![0].content!.parts,
            ...response.candidates![0].content!.parts!,
          ]))
        ]);
        emit(ChatLoaded(data: updatedModel));
      } else {
        emit(ChatLoaded(data: response));
      }
    } catch (e) {
      emit(ChatException(errorMessage: e.toString()));
    }
  }
}
