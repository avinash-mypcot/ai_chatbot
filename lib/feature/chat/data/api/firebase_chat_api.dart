import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

import '../model/chat_model.dart';

class FirebaseChatApi {

Future<ChatModel> getTodayChat() async {
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      final uId = auth.currentUser?.uid;

      final todayDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
      final snapshot = await FirebaseFirestore.instance
          .collection('chatModels')
          .doc(uId)
          .collection('chats')
          .doc(todayDate)
          .get();

      final data = snapshot.data();
      if (data == null) {
        // emit(ChatLoaded(
        //     data: ChatModel(
        //         date: todayDate,
        //         candidates: [Candidates(content: Content(parts: []))])));
        return ChatModel(
            date: todayDate,
            candidates: [Candidates(content: Content(parts: []))]);
      }
      final candidates;
      final contentJson;
      // Safely navigate the structure and deserialize the data
      final chats = data['chats'];
      if (chats!.runtimeType == List<dynamic>) {
        candidates = chats[0]['candidates'];

        contentJson = candidates[0]['content'] as Map<String, dynamic>?;
      } else {
        candidates = chats['0']['candidates'];

        contentJson = candidates['0']['content'] as Map<String, dynamic>?;
      }

      final content = Content.fromJson(contentJson!);

      // Parse parts and date
      List<Parts> parts = content.parts!;
      final timestamp = data['date'] as Timestamp?;
      final formattedDate = timestamp != null
          ? DateFormat('yyyy-MM-dd').format(timestamp.toDate())
          : "Unknown Date";

      final model = ChatModel(
        date: todayDate,
        candidates: [
          Candidates(content: content, date: formattedDate),
        ],
      );
      return model;
      // emit(ChatLoaded(data: model));
    } catch (e) {
      rethrow;
      // emit(ChatError(message: "Failed to load chat data"));
    }
  }


Future<void> appendPartsToFirestore(ChatModel chatModel, String documentId,{bool isNewChat = false}) async {
    try {
      // Initialize Firestore instance
      final firestore = FirebaseFirestore.instance;
      final FirebaseAuth auth = FirebaseAuth.instance;
      final uId = auth.currentUser!.uid;
      // Get today's date in 'yyyy-MM-dd' format for document ID
      // String documentId = DateFormat('yyyy-MM-dd').format(DateTime.now());

      // Extract the parts to be appended
      List<dynamic> newParts = chatModel.candidates!
          .expand((candidate) => candidate.content?.parts ?? [])
          .map((part) => part.toJson())
          .toList();

      // Reference the document
      final docRef = firestore
          .collection('chatModels')
          .doc(uId)
          .collection('chats')
          .doc(documentId);
      // final docRef = firestore.collection('chatModels').doc('2024-12-26');

      // Check if the document exists
      final docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        // Append new parts to the existing parts in Firestore
        if (isNewChat) {
          final leng = docSnapshot.data()!['chats'].length;
          await docRef.update({
            'chats.$leng.candidates.0.content.parts':
                FieldValue.arrayUnion(newParts),
          });
        } else {
          final leng = docSnapshot.data()!['chats'].length;
          await docRef.update({
            'chats.0.candidates.0.content.parts':
                FieldValue.arrayUnion(newParts),
          });
        }
      } else {
        // If document does not exist, create it
        await docRef.set({
          'chats': [chatModel.toJson()],
          'date': DateTime.now(),
        });
      }

      print("Parts successfully appended to Firestore!");
    } catch (e) {
      print("Error appending parts to Firestore: $e");
    }
  }

}