import '../../../chat/data/model/chat_model.dart';
import '../services/history_services.dart';

class HistoryRepository {
  final HistoryServices _services;
  const HistoryRepository({required HistoryServices service})
      : _services = service,
        super();

  Future<List<ChatModel>> getHistory() async {
    try {
      final response = await _services.getHistory();
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
