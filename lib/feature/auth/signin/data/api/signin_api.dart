import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../model/signin_model.dart';

class SigninApi {
  // FirebaseAuth auth = FirebaseAuth.instance;
  final SupabaseClient _supabaseclient = Supabase.instance.client;

  Future<SigninModel> signinReq(Map<String, dynamic> body) async {
    try {
      // final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      //     email: body["email"], password: body["password"]);
      final credential = await _supabaseclient.auth.signInWithPassword(
          email: body["email"], password: body["password"]);

      log("Response: ${credential.user}");
      return SigninModel(message: "User Login");
    } on FirebaseAuthException {
      rethrow;
    }
  }
}
