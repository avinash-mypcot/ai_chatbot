import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../model/profile_model.dart';

class ProfileApi {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final SupabaseClient supabase = Supabase.instance.client;

  Future<ProfileModel> getProfileData() async {
    // final uId = await auth.currentUser!.uid;
    final uId =  supabase.auth.currentUser!.id;
    try {
      // Fetch the document by its ID (assuming the document ID is passed)


      final response = await supabase
    .from('chat_models')
    .select('profile') // Select only the 'profile' column
    .eq('user_id', uId).limit(1) // Ensures only one record is retrieved
    .single(); 
      // DocumentSnapshot docSnapshot =
      //     await firestore.collection('chatModels').doc(uId).get();
      log("$response");
      if (response['profile'] != null ) {
        var data = response;
        data = data['profile'];
        // Convert the Firestore document to a ProfileModel
        ProfileModel profileModel = ProfileModel.fromMap(data);

        return profileModel;
      } else {
        return ProfileModel(name: '', email: '', mobile: '');
      }
    } catch (e) {
      log("Exception :$e");
      throw Exception('Failed to fetch profile data');
    }
  }

  Future<ProfileModel> updateProfileData(Map<String, dynamic> body) async {
    // final uId = auth.currentUser!.uid;
    final uId =  supabase.auth.currentUser!.id;
    try {
      await supabase
    .from('chat_models')
    .update({"profile":body}) // Select only the 'profile' column
    .eq('user_id', uId);
      // await firestore.collection('chatModels').doc(uId).set({"profile": body});

      return await getProfileData();
    } catch (e) {
      throw Exception('Failed to store profile data');
    }
    // return ProfileModel();
  }
}
