import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/chat_model.dart';

Future<void> storeChatModelToFirestore(ChatModel chatModel) async {
  try {
    // Initialize Firestore instance
    final firestore = FirebaseFirestore.instance;

    // Convert ChatModel to JSON
    Map<String, dynamic> chatModelJson = chatModel.toJson();

    // Save to Firestore
    await firestore.collection('chatModels').add(chatModelJson);

    print("ChatModel data successfully stored in Firestore!");
  } catch (e) {
    print("Error storing ChatModel data: $e");
  }
}
