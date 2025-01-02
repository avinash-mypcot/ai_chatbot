import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/chat_model.dart';

Future<void> appendPartsToFirestore(
    ChatModel chatModel, String documentId) async {
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
      await docRef.update({
        'chats.0.candidates.0.content.parts': FieldValue.arrayUnion(newParts),
      });
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
