import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/profile_model.dart';

class ProfileApi {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<ProfileModel> getProfileData() async {
    try {
      // Fetch the document by its ID (assuming the document ID is passed)
      DocumentSnapshot docSnapshot =
          await firestore.collection('chatModels').doc('1212').get();
      log("$docSnapshot");
      if (docSnapshot.exists) {
        // Convert the Firestore document to a ProfileModel
        ProfileModel profileModel =
            ProfileModel.fromMap(docSnapshot.data() as Map<String, dynamic>);

        return profileModel;
      } else {
        throw Exception('Profile not found');
      }
    } catch (e) {
      throw Exception('Failed to fetch profile data');
    }
  }

  Future<ProfileModel> updateProfileData(Map<String, dynamic> body) async {
    try {
      await firestore.collection('chatModels').doc('1212').set(body);

      return await getProfileData();
    } catch (e) {
      throw Exception('Failed to store profile data');
    }
    // return ProfileModel();
  }
}
