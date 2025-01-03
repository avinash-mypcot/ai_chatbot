import 'package:ai_chatbot/feature/history/data/repository/history_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/model/history_model.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final HistoryRepository _repository;
  HistoryBloc({required HistoryRepository repository})
      : _repository = repository,
        super(HistoryInitial()) {
    on<GetHistoryEvent>(_onGetHistory);
  }
  _onGetHistory(event, emit) async {
    try {
      HistoryModel model = await _repository.getHistory();
      emit(HistoryLoaded(model: model));
    } catch (e) {
      emit(HistoryException(msg: e.toString()));
      rethrow;
    }
  }
}
