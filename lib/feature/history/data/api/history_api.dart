import 'package:ai_chatbot/feature/chat/data/model/chat_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

 class HistoryApi{
  const HistoryApi();
  Future<List<ChatModel>> getHistory()async{
     try {
      // Fetch data from Firestore
      final snapshot = await FirebaseFirestore.instance
          .collection('chatModels') // your Firestore collection name
          .orderBy('date', descending: true) // Assuming there's a date field
          .get();
      // Map Firestore data to ChatModel
      final fetchedChats = snapshot.docs.map((doc) {
        var data = doc.data();

        dynamic content1 = data['chats'].runtimeType == List
            ? data['chats'][0]['candidates'][0]['content']
            : data['chats']['0']['candidates']['0']['content'];
        var content = Content.fromJson(content1);

        List<Parts> parts = content.parts ?? [];
        final dateTime = (data['date'] as Timestamp).toDate();
        final formattedDate =
            DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
        return ChatModel(
          candidates: [
            Candidates(content: Content(parts: parts), date: formattedDate)
          ],
        );
      }).toList();

     
      return fetchedChats;
     
    } catch (e) {
      print("Error fetching chat history: $e");
      rethrow;

    }
  }
}